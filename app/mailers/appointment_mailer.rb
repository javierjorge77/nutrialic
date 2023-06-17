class AppointmentMailer < ApplicationMailer
  def notifyCreation(professional_email, professional_name, user_name, appointment_date, appointment_time)
    @professional_name = professional_name 
    @user_name = user_name
    @appointment_date = appointment_date
    @appointment_time = appointment_time
    mail to: professional_email, subject: "Nutrialic nueva cita"
  end
  
  def notifyConfirmation(user_name, user_email, professional_name)
    @professional_name = professional_name 
    @user_name = user_name
    mail to: user_email, subject: "Nutrialic cita aprobada"
  end

  def notifyCancelation(user_name, user_email, professional_name)
    @professional_name = professional_name 
    @user_name = user_name
    mail to: user_email, subject: "Nutrialic cita rechazada"  
  end
end


