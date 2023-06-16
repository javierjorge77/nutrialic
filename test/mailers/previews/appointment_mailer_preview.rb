# Preview all emails at http://localhost:3000/rails/mailers/appointment_mailer
class AppointmentMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/appointment_mailer/notifyConfirmation
  def notifyConfirmation
    AppointmentMailer.notifyConfirmation
  end

end
