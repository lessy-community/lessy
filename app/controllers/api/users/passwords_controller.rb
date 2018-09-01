class Api::Users::PasswordsController < ApiController
  skip_before_action :require_login, only: [:create]
  skip_before_action :require_tos_accepted, only: [:create]

  def create
    @user = User.find_by_sorcery_token!(params[:token], type: :reset_password)
    if @user.inactive?
      render_errors [ApiErrors::UserInactive.new], :unprocessable_entity
      return
    end
    @user.change_password! password_param
    @token = @user.token(1.month.from_now)
  end

private

  def password_param
    fetch_resource_params(:user, [:password])[:password]
  end
end
