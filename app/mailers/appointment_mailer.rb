class AppointmentMailer < ApplicationMailer
  def notifyCreation
    mail to: "saratiel69@gmail.com", subject: "Hola, tienes una nueva cita"
  end
  
  def notifyConfirmation
    mail to: "saratiel69@gmail.com", subject: "Tu cita ha sido aprobada"
  end

  def notifyCancelation
    mail to: "saratiel69@gmail.com", subject: "Tu cita ha sido cancelada"
  end
end
