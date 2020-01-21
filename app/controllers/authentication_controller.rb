class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def status
    render json: { status: 'All systems are working fine' }, status: :ok
  end

  # rubocop:disable Layout/IndentHash, Metrics/MethodLength, Metrics/LineLength
  def authenticate
    email = authentication_params['email']
    password = authentication_params['password']

    command = Security::AuthenticateUser.call(email, password)
    if command.success?
      user = User.find_by(email: email)
      render json:  {
                      auth_token: command.result,
                      message: 'Set the provided auth_token as Authorization request header value.'
                    }, status: :ok
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  private

  def authentication_params
    params
      .transform_keys { |key| key.to_s.underscore }
      .permit(
        :email,
        :password,
      )
  end
end
