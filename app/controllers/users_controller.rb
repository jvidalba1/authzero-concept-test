class UsersController < ApplicationController

  # respond_to :json

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
      redirect_to root_path

    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  private

    def user_params
      params.require(:user).permit(:email, :nickname, :password, :name, :user_id)
    end
end
