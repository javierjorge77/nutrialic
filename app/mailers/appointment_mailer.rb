class AppointmentMailer < ApplicationMailer
  def notifyConfirmation
    mail to: "saratiel69@gmail.com", subject: "Funciona"
  end
end
