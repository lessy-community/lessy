# frozen_string_literal: true

class Api::Users::ActivationEmailsController < ApiController
  skip_before_action :require_login, only: [:create]
  skip_before_action :require_tos_accepted, only: [:create]

  def create
    user = User.find_by!(find_user_params)
    UserMailer.activation_needed_email(user).deliver_later if user.inactive?
    head :no_content
  end

  private

  def find_user_params
    fetch_resource_params(:user, [:email])
  end
end
