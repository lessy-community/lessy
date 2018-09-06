class JsonWebToken
  def self.encode(data, expiration)
    payload = {
      data: data,
      exp: expiration.to_i,
    }
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
  end

  def self.decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base, 'HS256')[0]
      HashWithIndifferentAccess.new body
  rescue JWT::DecodeError => e
    Rails.logger.warn "JsonWebToken.decode: #{ e.message }"
    nil
  end
end
