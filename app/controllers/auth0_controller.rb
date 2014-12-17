class Auth0Controller < ApplicationController
  def callback
    session[:userinfo] = request.env['omniauth.auth'].credentials.id_token
    redirect_to root_path
  end

  def failure
    @error_msg = request.params['message']
  end
end
