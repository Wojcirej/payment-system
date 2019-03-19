class JsonWebToken

  HMAC_SECRET = ENV['JSON_WEB_TOKEN_SERET_KEY']

  def self.encode(payload, expiration = 24.hours.from_now)
    payload[:exp] = expiration.to_i
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    begin
      body = JWT.decode(token, HMAC_SECRET)[0]
      HashWithIndifferentAccess.new(body)
    rescue JWT::ExpiredSignature, JWT::DecodeError => error
      { error: error.class, message: error.message }.with_indifferent_access
    end
  end
end
