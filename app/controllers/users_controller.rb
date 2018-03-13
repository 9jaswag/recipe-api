class UsersController < ApplicationController
  skip_before_action :authorize_request, only: %i[create login edit]
  def create
    user = User.create!(user_params)
    if user.save
      user.send_activation_email
      response = {
        message: "Signup successful! Activation link sent to email.",
        auth_token: nil
      }
      json_response(response, :created)
    else
      render json: user.errors, status: :bad
    end
  end

  # activate a user
  def edit
    user = User.find_by(email: params[:email])
    activate_user(user)
  end

  def login
    # return auth token once user is authenticated
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    response = {
      message: "User login successful!",
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

    def activate_user(user)
      raise(
        ExceptionHandler::BadRequest,
        'Account activation failed!'
      ) unless user && !user.activated && user.authenticated?(:activation, params[:token])
      user.activate
      json_response('Account activation successful!', nil, :created)
    end
end
