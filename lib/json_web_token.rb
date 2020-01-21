class JsonWebToken
  class << self

    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, auth_token)
    end

    def decode(token)
      body = JWT.decode(token, auth_token)[0]
      HashWithIndifferentAccess.new body
    rescue
      nil
    end

    def auth_token
      %w[test development].include?(Rails.env) ? 'access_token' : ENV['TOKEN_AUTH_SECRET']
    end

  end
end
