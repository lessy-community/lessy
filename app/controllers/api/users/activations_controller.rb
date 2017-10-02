class Api::Users::ActivationsController < ApplicationController

  skip_before_action :require_login, only: [:create]

  def create
    @user = User.load_from_activation_token(params[:token])
    unless @user
      raise ActiveRecord::RecordNotFound.new "Couldn't find User with token=#{ params[:token] }", User.name
    end
    @user.update! activate_user_params
    @user.activate!
    @token = @user.token(1.month.from_now)
  end

private

  def activate_user_params
    fetch_resource_params(:user, [:username, :password])
  end

end
