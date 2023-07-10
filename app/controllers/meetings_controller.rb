class MeetingsController < ApplicationController
    def index
        @user = current_user
        @sdk_key = ENV['ZOOM_CLIENT_ID']
        @secret_key = ENV['ZOOM_SECRET_ID']
        @meeting_id = params[:meeting_id]
        @appointment = Appointment.find_by(online_reunion_id: @meeting_id)
        if @appointment.present?
            @professional = Professional.find(@appointment.professional_id)
            @professional_username = @professional.username
        else
            puts "Oh no! Appointment was not found"
        end
    end
end