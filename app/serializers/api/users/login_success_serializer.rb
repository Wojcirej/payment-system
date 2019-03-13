class Api::Users::LoginSuccessSerializer < Api::BaseSerializer
  attributes :id, :username, :email, :current_token, :message

  def message
    "Login successfully."
  end
end
