class Api::UsersController < ApplicationController

  def create
    @user = User.new(create_user_params)
    @user.save
    render status: :created
  rescue ActiveRecord::RecordNotUnique
    render_error 'This email is already taken'
  rescue ActionController::ParameterMissing => error
    @message = error.message
    render 'api/errors/parameter_missing', status: :bad_request
  end

private

  def create_user_params
    params.require(:user).permit(:email).tap do |user_params|
      user_params.require(:email)
    end
  end

end
