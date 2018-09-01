# frozen_string_literal: true

class Api::Users::PasswordResetsController < ApiController
  skip_before_action :require_login, only: [:create]
  skip_before_action :require_tos_accepted, only: [:create]

  def create
    @user = User.find_by!(find_user_params)
    if @user.inactive?
      render_error ApiErrors::UserInactive.new, :unprocessable_entity
      return
    end
    @user.deliver_reset_password_instructions!
    head :no_content
  end

  private

  def find_user_params
    fetch_resource_params(:user, [:email])
  end
end
