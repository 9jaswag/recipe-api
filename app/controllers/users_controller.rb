class UsersController < ApplicationController
  skip_before_action :authorize_request, only: %i[create login edit]
  def create
    user = User.create(user_params)
    if user.save
      user.send_activation_email
      json_response('Signup successful! Activation link sent to email.', nil, :created)
    else
      render json: user.errors, status: :bad
    end
  end

  def edit
    user = User.find_by(email: params[:email])
    activate_user(user)
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

    def activate_user(user)
      if user && !user.activated && user.authenticated?(:activation, params[:token])
        user.activate
        json_response('Account activation successful!', nil, :created)
      else
        json_response('Account activation failed!', nil, :bad)
      end
    end
end
