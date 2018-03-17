class UsersController < ApplicationController
  skip_before_action :authorize_request, only: %i[create login edit]
  def create
    user = User.create!(user_params)
    if user.save
      user.send_activation_email
      response = { message: "Signup successful! Activation link sent to email." }
      json_response(response, :created)
    else
      render json: user.errors, status: :bad
    end
  end

  # activate a user
  def edit
    user = User.find_by(email: params[:email])
    user.activate_user(params[:token])
    response = { message: "Account activation successful! Please log in" }
    json_response(response, :created)
  end

  def login
    # return auth token once user is authenticated
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    response = {
      message: 'User login successful!',
      auth_token: auth_token
    }
    json_response(response)
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end

  def auth_params
    params.permit(:email, :password)
  end
end
