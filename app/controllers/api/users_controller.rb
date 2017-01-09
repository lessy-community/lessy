class Api::UsersController < ApplicationController

  def create
    @user = User.new(create_user_params)
    @user.save
    @token = @user.token(1.day.from_now)
    render status: :created
  rescue ActiveRecord::RecordNotUnique
    render_error 'This email is already taken'
  rescue ActionController::ParameterMissing => error
    render_error error.message
  end

  def activate
    @user = User.load_from_activation_token(params[:token])
    if @user
      @user.update! activate_user_params
      @user.activate!
      @token = @user.token(1.month.from_now)
    else
      render_error 'The token matches no user'
    end
  rescue ActiveRecord::RecordNotUnique
    render_error 'This username is already taken'
  rescue ActionController::ParameterMissing, ActiveRecord::RecordInvalid => error
    render_error error.message
  end

  def authorize
    user = User.authenticate(params[:username], params[:password])
    if user
      @token = user.token(1.month.from_now)
    else
      render_error 'Bad credentials', :unauthorized
    end
  end

  def me
    if decoded_token
      @user = User.find(decoded_token[:user_id])
    else
      render_error 'Authentication is required', :unauthorized
    end
  end

private

  def create_user_params
    params.require(:user).permit(:email).tap do |user_params|
      user_params.require(:email)
    end
  end

  def activate_user_params
    params.require(:user).permit(:username, :password).tap do |user_params|
      user_params.require([:username, :password])
    end
  end

  def decoded_token
    JsonWebToken.decode(request.headers['Authorization'])
  end

end
