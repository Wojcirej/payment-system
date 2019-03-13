class Api::Users::RegisterSerializer < Api::BaseSerializer
  attributes :id, :username, :email
end
