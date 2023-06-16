# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
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

    if @appointment.valid? && appointment_is_valid?
      @appointment.save
      redirect_to "/", notice: "La cita ha sido guardada exitosamente"
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
    if @appointment.update(aprobado: params[:appointment][:aprobado])
      AppointmentMailer.notifyConfirmation.deliver_now
      flash[:notice] = "La cita ha sido aprobada por ti"
      redirect_to root_path
    else
      render :edit
    end
  end
  
  def destroy
    @professional = Professional.find(params[:professional_id])
    @appointment = @professional.appointments.find(params[:id])
    @appointment.destroy 
    flash[:notice] = "La cita ha sido eliminada correctamente"
    redirect_to root_path
  end
  
private

  def appointment_params
    params.require(:appointment).permit(:first, :online, :time, :date)
  end


  # def send_email
  #   receptor = @appointment.user.email
  #   fecha = @appointment.date
  #   texto = "#{@appointment.professional.user.name} #{@appointment.professional.user.lastname} te atenderá en #{@appointment.professional.adress}, el día #{fecha} \n para cualquier duda previa puedes escribir o llamar por teléfono: #{@appointment.professional.user.phone}"

  #   from = SendGrid::Email.new(email: 'daniel_carrillo_2003@outlook.com')
  #   to = SendGrid::Email.new(email: receptor)
  #   subject = "Cita agendada en Nutrialic: #{fecha} "
  #   content = SendGrid::Content.new(type: 'text/plain', value: texto)
  #   mail = SendGrid::Mail.new(from, subject, to, content)

  #   sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  #   response = sg.client.mail._('send').post(request_body: mail.to_json)
  #   puts response.status_code
  #   puts response.body
  #   # puts response.parsed_body
  #   puts response.headers
  # end

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
