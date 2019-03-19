class Users::Login

  def initialize(credentials)
    @credentials = credentials
    @response_object = Hash.new
  end

  def self.call(credentials)
    new(credentials).call
  end

  def call
    user = User.find_by(username: credentials[:username])
    if user.nil?
      response_object.merge!(user: User.new(username: credentials[:username]))
    elsif user.authenticate(credentials[:password])
      response_object.merge!(user: user, token: JsonWebToken.encode({ user_id: user.id }))
    else
      response_object.merge!(user: user)
    end
    return response_object
  end

  private
  attr_reader :credentials, :response_object
end
