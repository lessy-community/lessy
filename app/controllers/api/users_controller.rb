class Api::UsersController < ApplicationController

  skip_before_action :require_login, except: [:me]

  def create
    @user = User.create!(create_user_params)
    @token = @user.token(1.day.from_now)
    render status: :created
  end

  def activate
    @user = User.load_from_activation_token(params[:token])
    unless @user
      raise ActiveRecord::RecordNotFound.new "Couldn't find User with token=#{ params[:token] }", User.name
    end
    @user.update! activate_user_params
    @user.activate!
    @token = @user.token(1.month.from_now)
  end

  def authorize
    @user = User.authenticate(params[:username], params[:password])
    if @user
      @token = @user.token(1.month.from_now)
    else
      render_custom_error 'Bad credentials', :login_failed, :unauthorized
    end
  end

  def me
    @user = current_user
    user_projects = @user.projects
    @projects = user_projects.not_finished
    @number_finished_projects = user_projects.finished.count
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

end
