module AuthenticationHelper
  # generate tokens from user id
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  # generate expired tokens from user id
  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id}, (Time.now.to_i - 10))
  end

  def valid_headers(user)
    {
      'Content-Type':   'application/json',
      'Authorization':  token_generator(user.id)
    }
  end

  def invalid_headers
    {
      'Content-Type':   'application/json',
      'Authorization':  nil
    }
  end
end
