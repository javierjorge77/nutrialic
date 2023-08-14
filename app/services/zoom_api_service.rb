class ZoomApiService
    include HTTParty

    base_uri 'https://zoom.us'
  
    def initialize(client_id, client_secret, account_id)
      @auth = { username: client_id, password: client_secret }
      @account_id = account_id
    end
  
    def get_access_token
      response = self.class.post('/oauth/token', body: { grant_type: 'account_credentials', account_id: @account_id }, basic_auth: @auth)
      response['access_token']
    end
  
    def get_meeting_status(access_token, meeting_id)
      headers = { 'Authorization' => "Bearer #{access_token}" }
      response = self.class.get("/v2/meetings/#{meeting_id}", headers: headers)
      response['status']
    end
end