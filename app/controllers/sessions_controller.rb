class SessionsController < ApplicationController 
    skip_before_action :authenticate_user!, only: :login_with_token
    def login_with_token
        appointment = Appointment.find_by(authentication_token: params[:authentication_token])

        if appointment && appointment.professional.user
        sign_in(appointment.professional.user) # Inicia sesión automáticamente al profesional asociado con la cita
        redirect_to professional_appointments_path(appointment.professional.id) # Redirige al profesional a appointments_path
        else
        redirect_to root_path, alert: 'Token de autenticación no válido' # Maneja el caso de token no válido
        end
    end
end