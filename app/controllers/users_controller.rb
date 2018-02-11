class UsersController < ApplicationController
  skip_before_action :authorize_request, only: %i[create login]
  def create
    user = User.create(user_params)
    if user.save
      # authenticate user
      auth_token = AuthenticateUser.new(user.email, user.password).call
      json_response('User signup successful!', auth_token, :created)
    else
      render json: user.errors, status: :bad
    end
  end

  def login
    # return auth token once user is authenticated
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response('User login successful!', auth_token, :ok)
  end

  private
    def user_params
      params.permit(:username, :email, :password)
    end

    def auth_params
      params.permit(:email, :password)
    end

    def json_response(message, auth_token, status)
      response = { message: message, auth_token: auth_token }
      render json: response, status: status
    end
end
