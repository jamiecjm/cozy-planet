class  Api::V1::GoogleController < ActionController::Base

  def get_auth_url
    credentials = Google::Auth::UserRefreshCredentials.new(
      client_id: ENV['google_client_id'],
      client_secret: ENV['google_client_secret'],
      scope: [
        'https://www.googleapis.com/auth/drive',
        'https://spreadsheets.google.com/feeds/',
      ],
      redirect_uri: ENV['google_redirect_uri']
    )
    redirect_to credentials.authorization_uri.to_s
  end

  def start_session
    credentials = Google::Auth::UserRefreshCredentials.new(
      client_id: ENV['google_client_id'],
      client_secret: ENV['google_client_secret'],
      scope: [
        'https://www.googleapis.com/auth/drive',
        'https://spreadsheets.google.com/feeds/',
      ],
      redirect_uri: ENV['google_redirect_uri'],
      additional_parameters: { 'access_type' => 'offline' }
    )
    credentials.code = params[:code]
    credentials.fetch_access_token!
    session = GoogleDrive::Session.from_credentials(credentials)
  end


end
