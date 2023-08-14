class Api::V1::ZoomApiController < ApplicationController
    def get_access_token
      client_id =  ENV['OAUTH_CLIENT_ID']
      client_secret = ENV['OAUTH_CLIENT_SECRET']
      account_id = ENV['OAUTH_ACCOUNT_ID']

      zoom_service = ZoomApiService.new(client_id, client_secret, account_id)
      access_token = zoom_service.get_access_token
  
      render json: { access_token: access_token }
    end
  
    def get_meeting_status
      access_token = params[:access_token]
      meeting_id = params[:meeting_id]
      
      client_id =  ENV['OAUTH_CLIENT_ID']
      client_secret = ENV['OAUTH_CLIENT_SECRET']
      account_id = ENV['OAUTH_ACCOUNT_ID']

      zoom_service = ZoomApiService.new(client_id, client_secret, account_id)
      status = zoom_service.get_meeting_status(access_token, meeting_id)
    
      render json: { meeting_status: status }
    end
  end