class Api::UsersController < ApplicationController

  def create
    user = User.new(registration_params)
    status = user.save ? :created : :unprocessable_entity
    render json: user, status: status, serializer: Api::Users::RegisterSerializer
  end

  def login
    user = ::Users::Login.call(login_params)
    if user.current_token
      status = 200
      serializer = Api::Users::LoginSuccessSerializer
    else
      status = 401
      serializer = Api::Users::LoginFailureSerializer
    end
    render json: user, status: status, serializer: serializer
  end

  private

  def registration_params
    params = ActionController::Parameters.new(json)
    params.permit(:username, :password, :password_confirmation, :email)
  end

  def login_params
    params = ActionController::Parameters.new(json)
    params.permit(:username, :password)
  end
end
