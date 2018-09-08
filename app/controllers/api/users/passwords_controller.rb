# frozen_string_literal: true

class Api::Users::PasswordsController < ApiController
  skip_before_action :require_login, if: -> { params[:token] }
  skip_before_action :require_tos_accepted, if: -> { params[:token] }
  before_action :require_sudo, if: -> { !params[:token] }

  before_action :set_user, only: [:create]
  before_action do
    require_active_user(@user)
  end

  def create
    @user.change_password! password_param
    @token = @user.token(expiration: 1.month.from_now) if params[:token]
  end

  private

  def set_user
    @user = if params[:token]
              User.find_by_sorcery_token!(params[:token], type: :reset_password)
            else
              current_user
            end
  end

  def password_param
    fetch_resource_params(:user, [:password])[:password]
  end
end
