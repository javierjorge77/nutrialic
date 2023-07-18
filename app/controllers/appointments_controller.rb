# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
require 'net/http'
require 'base64'
require 'json'
require 'stripe_service'
require 'product'
include SendGrid

class AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def show
        
  end
  

  def new
    @appointment = Appointment.new
    @professional = Professional.find(params[:professional_id])
  end

  def create
    @professional = Professional.find(params[:professional_id])
    @appointment = Appointment.new(appointment_params)
    @appointment.user = current_user
    @appointment.professional = @professional
    @appointment.date = Date.parse(params[:appointment][:date]) if params[:appointment][:date].present?
    @appointment.authentication_token = Devise.friendly_token
    professional_name = "#{@professional.user.name} #{@professional.user.lastname}"
    if @appointment.valid? && appointment_is_valid?
      if current_user.appointments.where(professional_id: @professional.id).exists?
        @appointment.first = false
        amount_to_be_paid = @appointment.professional.follow_cost * 100
      else 
        @appointment.first = true
        amount_to_be_paid =  @appointment.professional.first_cost * 100;
      end
      product_name = "Consulta con #{professional_name}"
      description = "Esta pago es un cobro realizado para la confirmacion de una cita con el nutriologo"
      product = Product.stripe_nutritionist(@appointment.professional.id, product_name, description, amount_to_be_paid)
        
      session = StripeService.create_checkout_session(
        current_user,
        product,
        success_url: success_checkouts_url(session_id: ''),
        cancel_url: root_url,
        appointment_online: @appointment.online,
        appointment_time: @appointment.time,
        appointment_date: @appointment.date,
        appointment_first: @appointment.first,
        appointment_user_id: @appointment.user_id,
        appointment_professional_id: @appointment.professional_id,
        appointment_autentication_token: @appointment.authentication_token
      )
      if session.success?
        puts session
        redirect_to session.url, allow_other_host: true
      else
        flash[:alert] = session.error
        redirect_to root_url
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    if current_user.nutritionist?
      if current_user.professional.id == params[:professional_id].to_i
        @professional = Professional.find(params[:professional_id])
      else
        flash[:notice] = "No tienes permiso de acceder a las citas de otro profesional"
        redirect_to root_path
      end
    else
      flash[:notice] = "No tienes permiso de acceder a esta pagina"
      redirect_to root_path
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    appointment = @appointment
    user_name = "#{@appointment.user.name} #{@appointment.user.lastname}"
    user_email = @appointment.user.email
    professional_name = "#{@appointment.professional.user.name} #{@appointment.professional.user.lastname}"
    professional_email = @appointment.professional.user.email 
    professional_username = @appointment.professional.username 
    appointment_date = @appointment.date.strftime("%Y-%m-%d") 
    appointment_time_fixed = @appointment.time + 6.hours
    appointment_time = appointment_time_fixed.strftime("%H:%M:%S")
    start_datetime = "#{appointment_date}T#{appointment_time}Z"
    if @appointment.update(aprobado: params[:appointment][:aprobado]) && @appointment.online
      create_online_appointment(appointment, user_name, user_email, professional_name, professional_email, start_datetime)
      id = @appointment.checkout_session_id
      payment = StripeService.capture_payment(id)
      if payment.success?
        puts payment
      else
        puts 'it failed'
        puts payment.error if payment.error
      end
      AppointmentMailer.notifyConfirmation(user_name, user_email, professional_name, @appointment.online_reunion_id)
      AppointmentMailer.appointmentReminder(user_name, user_email, professional_name).deliver_later(wait_until: @appointment.date.to_datetime + @appointment.time.seconds_since_midnight.seconds - 5.hours)
    elsif  @appointment.update(aprobado: params[:appointment][:aprobado]) && !@appointment.online
      create_normal_appointment(appointment, user_name, user_email, professional_name)
      id = @appointment.checkout_session_id
      payment = StripeService.capture_payment(id)
      if payment.success?
        puts payment
      else
        puts 'it failed'
        puts payment.error if payment.error
      end
      AppointmentMailer.notifyConfirmation(user_name, user_email, professional_name, 0)
      AppointmentMailer.sendReviewLink(user_name, user_email, professional_name, professional_username).deliver_later(wait_until: @appointment.date.to_datetime + @appointment.time.seconds_since_midnight.seconds + 1.hour)
      AppointmentMailer.appointmentReminder(user_name, user_email, professional_name).deliver_later(wait_until: @appointment.date.to_datetime + @appointment.time.seconds_since_midnight.seconds - 5.hours)
    else
      render :edit
    end
  end
  
  def destroy
    @professional = Professional.find(params[:professional_id])
    @appointment = @professional.appointments.find(params[:id])
    user_name = "#{@appointment.user.name} #{@appointment.user.lastname}"
    user_email = @appointment.user.email
    professional_name = "#{@appointment.professional.user.name} #{@appointment.professional.user.lastname}"
    AppointmentMailer.notifyCancelation(user_name, user_email, professional_name).deliver_now
    id = @appointment.checkout_session_id
    cancel_payment = StripeService.cancel_payment_authorization(id)
    if cancel_payment.success?
      puts cancel_payment
    else
        puts 'it failed'
        puts cancel_payment.error if cancel_payment.error
    end
    @appointment.destroy 
    flash[:notice] = "La cita ha sido eliminada correctamente"
    redirect_to root_path
  end
  
  private

  def appointment_params
    params.require(:appointment).permit(:online, :time, :date)
  end

  def create_normal_appointment(appointment, user_name, user_email, professional_name)
    flash[:notice] = "Cita aprobada con exito"
    redirect_to professional_appointments_path(current_user.professional.id)
    AppointmentMailer.notifyConfirmation(user_name, user_email, professional_name, 0).deliver_now
  end
  

  def create_online_appointment(appointment, user_name, user_email, professional_name, professional_email, start_datetime)
    params = {
      grant_type: 'account_credentials',
      account_id: 'veszz43ySs2F5GuxGNPARg'
    }
    url = URI.parse('https://zoom.us/oauth/token')
    request = Net::HTTP::Post.new(url.request_uri)
    request.basic_auth('qRu4sb4eSh2KiiRWRbH4RA', 'Ix04IDo2GHNu1vCrsYR0K2vADuNf8hBK')
    request.set_form_data(params)
    response = Net::HTTP.start(url.host, url.port, use_ssl: true) do |http|
      http.request(request)
    end
    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)
      access_token = data['access_token']
    else
      puts "Error: #{response.code} #{response.message}"
      puts response.body
    end
    if access_token 
      url = URI.parse('https://api.zoom.us/v2/users/me/meetings')
      request = Net::HTTP::Post.new(url.request_uri)
      request['Authorization'] = "Bearer #{access_token}"
      request['Content-Type'] = 'application/json'
      meeting_data = {
        "topic": "Testing server to server app from local app",
        "type": 2,
        "start_time": start_datetime,
        "duration": 40,
        "password": "nu7ri4",
        "settings": {
          "join_before_host": true,
          "schedule_for": professional_email,
          "allow_multiple_meetings": true
        },
        "host_id": "832893"
      }
      request.body = meeting_data.to_json
      response = Net::HTTP.start(url.host, url.port, use_ssl: true) do |http|
        http.request(request)
      end
      if response.is_a?(Net::HTTPSuccess)
        meeting_info = JSON.parse(response.body)
        puts "Cita creada exitosamente:"
        puts meeting_info
        appointment.update(online_reunion_id: meeting_info["id"])
        flash[:notice] = "Cita aprobada con exito"
        redirect_to professional_appointments_path(current_user.professional.id)
        meeting_number_id = appointment.online_reunion_id
      else
        puts "Error al crear la cita: #{response.code} #{response.message}"
        puts response.body
      end
    else
      puts "No token available"
    end
    if meeting_number_id
      AppointmentMailer.notifyConfirmation(user_name, user_email, professional_name, meeting_number_id).deliver_now
    end
  end
  
  def appointment_is_valid?
    start_attending_time = @professional.startAttendingTime
    end_attending_time = @professional.endAttendingTime

    appointment_time = @appointment.time

    # Verificar si la fecha de la cita es un sábado o domingo
    if @appointment.date.saturday? || @appointment.date.sunday?
      @appointment.errors.add(:date, "La cita no puede ser programada en sábado o domingo")
      return false
    end

    if @appointment.date < Date.today
      @appointment.errors.add(:time, "La fecha de la cita no puede ser menor a la fecha actual")
      return false
    end

    # Verificar el horario de atención del nutriologo
    if appointment_time < start_attending_time || appointment_time > end_attending_time
      @appointment.errors.add(:time, "La cita debe ser hecha entre el horario del nutriologo")
      return false
    end

    existing_appointments = @professional.appointments.where(date: @appointment.date)

    existing_appointments.each do |existing_appointment|
      if (existing_appointment.time - appointment_time).abs < 1.hour
        @appointment.errors.add(:time, "La cita se superpone con otra cita existente")
        return false
      end
    end

    true
  end


end
