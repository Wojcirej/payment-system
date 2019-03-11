class Api::UsersController < ApplicationController

  def create
    @user = User.new(registration_params)
    status = @user.save ? :created : :unprocessable_entity
    render json: @user, status: status, serializer: Api::UserSerializer
  end

  private

  def registration_params
    params = ActionController::Parameters.new(json)
    params.permit(:username, :password, :password_confirmation, :email)
  end
end
