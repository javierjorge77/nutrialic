class AppointmentMailer < ApplicationMailer
  def notifyCreation(professional_email, professional_name, user_name, appointment_date, appointment_time)
    mail to: professional_email, subject: "Hola #{professional_name}, tienes una cita por confirmar con #{user_name} el dia #{appointment_date} a las #{appointment_time}"
  end
  
  def notifyConfirmation
    mail to: "saratiel69@gmail.com", subject: "Tu cita ha sido aprobada"
  end

  def notifyCancelation
    mail to: "saratiel69@gmail.com", subject: "Tu cita ha sido cancelada"
  end
end
