class CheckoutsController < ApplicationController 
    def success
        session_id_string = params[:session_id]
        just_id = session_id_string.sub("?session_id=", "")
        session = Stripe::Checkout::Session.retrieve(just_id)
        puts session
        appointment_autentication_token = session.metadata.appointment_autentication_token
        appointment_date = session.metadata.appointment_date
        appointment_first = session.metadata.appointment_first
        appointment_online = session.metadata.appointment_online 
        appointment_professional_id = session.metadata.appointment_professional_id 
        appointment_time = session.metadata.appointment_time
        appointment_user_id = session.metadata.appointment_user_id
        payment_intent = session.payment_intent
        if session.payment_status == "unpaid"
            @appointment = Appointment.new(first: appointment_first, online: appointment_online, time: appointment_time, user_id: appointment_user_id, professional_id: appointment_professional_id, date: appointment_date, authentication_token: appointment_autentication_token, checkout_session_id: payment_intent)
            if @appointment.save
            @professional = Professional.find(@appointment.professional_id)
            @user = User.find(@appointment.user_id)
            professional_email = @professional.user.email 
            professional_name = "#{@professional.user.name} #{@professional.user.lastname}"
            user_name = "#{@user.name} #{@user.lastname}" 
            appointment_date = @appointment.date 
            appointment_time = @appointment.time
            AppointmentMailer.notifyCreation(
                professional_email,
                professional_name,
                user_name,
                @appointment.date,
                @appointment.time,
                @appointment.authentication_token,
                @appointment.online
            ).deliver_now
            redirect_to "/appointments", notice: "Cita guardada exitosamente"
            else
            redirect_to root_path, alert: "Error al guardar la cita"
            end
        else
            redirect_to root_path, alert: "El pago no fue exitoso"
        end
    end
end
