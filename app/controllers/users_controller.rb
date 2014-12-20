class UsersController < ApplicationController

  include HTTParty
  format :json
  headers 'Accept' => 'application/json'
  # respond_to :json

  def post(path, options={})
    self.class.post(URI.encode(Figaro.env.endpoint + path), options)
  end

  def show
    # respond_with User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # here is where I have to make the request
      create_auth0_user(@user)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  def create_auth0_user(user, options={})
    access_token = get_access_token["access_token"]
    body = {  email: user.email,
              password: user.password,
              connection: "Username-Password-Authentication"#,
              # email_verified: false
            }.merge(options)
    post("/api/users?access_token=#{access_token}", body: body)
  end

  def get_access_token
    post("/oauth/token", body: {
                                  client_id:      Figaro.env.client_id,
                                  client_secret:  Figaro.env.client_secret,
                                  grant_type:     "client_credentials"
                                }).merge({ timestamp: Time.now })
  end

  def authenticate
    if @access_token
      if @access_token[:timestamp] < Time.now - 60*60*20
        @access_token = get_access_token
      else
        @access_token
      end
    else
      @access_token = get_access_token
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :nickname, :password, :name, :user_id)
    end
end
