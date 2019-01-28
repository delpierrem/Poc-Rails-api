class User::Login < Trailblazer::Operation
  require 'json_web_token'

  step :model!
  failure :log_error!
  step :authenticate_user!
  failure :log_error!
  step :auth_token!

  def model!(options, params:, **)
    options['model'] = User.find(email: params[:email])
  end

  def authenticate_user!(options, params:, **)
    options['model'].authenticate(params[:password])
  end

  def auth_token!(options)
    options['json'] = {
      auth_token: JsonWebToken.encode(user_id: options['model'].id)
    }.to_json
    options['status_code'] = :ok
  end

  def log_error!(options)
    options['json'] = {
      errors: {
        detail: 'Invalid email / password',
        status: '401'
      }
    }.to_json
    options['status_code'] = :unauthorized
  end
end
