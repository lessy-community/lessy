# frozen_string_literal: true

class Api::Users::PasswordResetsController < ApiController
  skip_before_action :require_login, only: [:create]
  skip_before_action :require_tos_accepted, only: [:create]

  before_action :set_user
  before_action do
    require_active_user(@user)
  end

  def create
    @user.deliver_reset_password_instructions!
    head :no_content
  end

  private

  def set_user
    find_user_params = fetch_resource_params(:user, [:email])
    @user = User.find_by!(find_user_params)
  end
end
