class Api::Users::PasswordsController < ApiController
  skip_before_action :require_login, only: [:create]
  skip_before_action :require_tos_accepted, only: [:create]

  def create
    @user = User.load_from_reset_password_token(params[:token])
    unless @user
      raise ActiveRecord::RecordNotFound.new "Couldn't find User with token=#{ params[:token] }", User.name
    end
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
