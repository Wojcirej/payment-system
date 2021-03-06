class Api::Users::LoginSuccessSerializer < Api::BaseSerializer
  attributes :id, :username, :email, :message

  def message
    "Login successfully."
  end
end
