class UsersController < ApplicationController
  def create
    user = User.create(user_params)
    if user.save
      # authenticate user
      auth_token = AuthenticateUser.new(user.email, user.password).call
      response = { message: 'User signup successful!', auth_token: auth_token }
      render json: response, status: :created
    else
      render json: user.errors, status: :bad
    end
  end

  def login
    # return auth token once user is authenticated
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    response = { message: 'User login successful!', auth_token: auth_token }
    render json: response, status: :ok
  end

  private
    def user_params
      params.permit(:username, :email, :password)
    end

    def auth_params
      params.permit(:email, :password)
    end
end
