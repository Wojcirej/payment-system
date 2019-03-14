class Users::Login

  def initialize(credentials)
    @credentials = credentials
  end

  def self.call(credentials)
    new(credentials).call
  end

  def call
    user = User.find_by(username: credentials[:username])
    if user.nil?
      return User.new(username: credentials[:username])
    elsif user.authenticate(credentials[:password])
      user.current_token = JsonWebToken.encode({ user_id: user.id })
      user.save
      return user
    else
      return user
    end
  end

  private
  attr_reader :credentials
end
