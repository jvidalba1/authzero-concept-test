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
    raise "O"
  end

  def update
    user = current_user
    if user.update_attributes(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    current_user.destroy
    head 204
  end

  private

    def user_params
      params.require(:user).permit(:email, :nickname, :password, :name, :user_id)
    end
end
