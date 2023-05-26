# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid

class AppointmentsController < ApplicationController
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
      send_email
      redirect_to "/", notice: "La cita ha sido guardada exitosamente"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @professional = Professional.find(params[:professional_id])
  end


private

  def appointment_params
    params.require(:appointment).permit(:first, :online, :time, :date)
  end


  def send_email
    receptor= @appointment.user.email
    fecha= @appointment.time
    texto = "#{@appointment.professional.user.name} #{@appointment.professional.user.lastname} te atenderá en #{@appointment.professional.adress}, el día #{fecha} \n para cualquier duda previa puedes escribir o llamar por teléfono: #{@appointment.professional.user.phone}"

    from = SendGrid::Email.new(email: 'javierjorge77@gmail.com')
    to = SendGrid::Email.new(email: receptor)
    subject = "Cita agendada en Nutrialic: #{fecha} "
    content = SendGrid::Content.new(type: 'text/plain', value: texto)
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    # puts response.parsed_body
    puts response.headers

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
