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

  private
    def user_params
      params.permit(:username, :email, :password)
    end
end
