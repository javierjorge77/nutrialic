class AppointmentMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def notifyCreation(professional_email, professional_name, user_name, appointment_date, appointment_time, auth_token)
    @professional_name = professional_name 
    @user_name = user_name
    @appointment_date = appointment_date
    @appointment_time = appointment_time
    #@auth_token = auth_token
    @authentication_token = auth_token
    mail to: professional_email, subject: "Nutrialic nueva cita"
  end
  
  def notifyConfirmation(user_name, user_email, professional_name, meeting_number_id)
    @professional_name = professional_name 
    @user_name = user_name
    @meeting_number_id = meeting_number_id
    if @meeting_number_id != 0 
      meeting_url = meeting_url(@meeting_number_id)
      @meeting_link = ActionController::Base.helpers.link_to 'Unirme a la reunión', meeting_url, class: 'btn btn-primary', id: 'joinMeetingBtn'
    end
    mail to: user_email, subject: "Nutrialic cita aprobada"
  end

  def notifyCancelation(user_name, user_email, professional_name)
    @professional_name = professional_name 
    @user_name = user_name
    mail to: user_email, subject: "Nutrialic cita rechazada"  
  end
end


