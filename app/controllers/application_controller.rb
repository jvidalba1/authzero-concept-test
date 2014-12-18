class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout 'lumen'

  before_action :signed_in?

  def signed_in?
    if session_active?
    end
  end

  private

  def session_active?
    session[:userinfo] && user_authorization
  end

  def user_authorization
    options = { body: { id_token: session[:userinfo] } }
    response = HTTParty.post("https://jvidalba.auth0.com/tokeninfo", options)
    # raise "eoelo"
    response.parsed_response.eql? "Unauthorized" ? false : true
    user_parsed(response)
  end

  def user_parsed(response)
    @current_user = response.parsed_response
  end

end
