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
    if @appointment.save
      send_email
      redirect_to "/"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @professional = Professional.find(params[:professional_id])
  end


private

  def appointment_params
    params.require(:appointment).permit(:first, :online, :time)
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

end
