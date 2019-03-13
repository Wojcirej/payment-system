class Api::Users::LoginFailureSerializer < Api::BaseSerializer
  attributes :username, :message

  def message
    "Incorrect credentials, please try again."
  end
end
