# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
require 'net/http'
require 'base64'
require 'json'
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
    professional_email = @professional.user.email 
    professional_name = "#{@professional.user.name} #{@professional.user.lastname}"
    user_name = "#{current_user.name} #{current_user.lastname}" 
    appointment_date = @appointment.date 
    appointment_time = @appointment.time
    @appointment.authentication_token = Devise.friendly_token
    auth_token =  @appointment.authentication_token
    if @appointment.valid? && appointment_is_valid?
      @appointment.save
      AppointmentMailer.notifyCreation(professional_email, professional_name, user_name, appointment_date, appointment_time, auth_token).deliver_now
      redirect_to "/appointments", notice: "La cita ha sido guardada exitosamente"
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
    user_name = "#{@appointment.user.name} #{@appointment.user.lastname}"
    user_email = @appointment.user.email
    professional_name = "#{@appointment.professional.user.name} #{@appointment.professional.user.lastname}"
    professional_email = @appointment.professional.user.email 
    appointment_date = @appointment.date.strftime("%Y-%m-%d") 
    appointment_time = @appointment.time.strftime("%H:%M:%S")
    start_datetime = "#{appointment_date}T#{appointment_time}Z"
    puts "Appointment date #{appointment_date}"
    puts "Appointment time #{appointment_time}"
    puts "start datetime #{start_datetime}"
    if @appointment.update(aprobado: params[:appointment][:aprobado])
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
        puts access_token
      else
        puts "Valio cacahuate mi mai"
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
          @appointment.update(online_reunion_id: meeting_info["id"])
          flash[:notice] = "Cita aprobada con exito"
          redirect_to professional_appointments_path(current_user.professional.id)
          meeting_number_id = @appointment.online_reunion_id
        else
          puts "Error al crear la cita: #{response.code} #{response.message}"
          puts response.body
        end
      else
        puts "No token available"
      end
      if meeting_number_id
        AppointmentMailer.notifyConfirmation(user_name, user_email, professional_name, meeting_number_id).deliver_now
      else
        AppointmentMailer.notifyConfirmation(user_name, user_email, professional_name).deliver_now
      end
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
    @appointment.destroy 
    flash[:notice] = "La cita ha sido eliminada correctamente"
    redirect_to root_path
  end
  
private

  def appointment_params
    params.require(:appointment).permit(:first, :online, :time, :date)
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
