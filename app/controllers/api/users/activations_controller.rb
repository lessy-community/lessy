class Api::Users::ActivationsController < ApiController
  skip_before_action :require_login, only: [:create]
  skip_before_action :require_tos_accepted, only: [:create]

  def create
    @user = User.find_by_sorcery_token!(params[:token], type: :activation)
    @user.update! activate_user_params
    @user.activate!
    @token = @user.token(1.month.from_now)
  end

private

  def activate_user_params
    fetch_resource_params(:user, [:username, :password])
  end
end
