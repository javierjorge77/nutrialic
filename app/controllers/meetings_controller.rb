class MeetingsController < ApplicationController
    def index
        @user = current_user
        @sdk_key = ENV['ZOOM_CLIENT_ID']
        @secret_key = ENV['ZOOM_SECRET_ID']
        @meeting_id = params[:meeting_id]
    end
end