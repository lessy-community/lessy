class Api::Users::AuthorizationsController < ApiController
  skip_before_action :require_login, only: [:create]
  skip_before_action :require_tos_accepted, only: [:create]

  def create
    @user = User.authenticate(params[:username], params[:password])
    unless @user
      render_error ApiErrors::LoginFailed.new, :unauthorized
      return
    end
    sudo_mode = params[:sudo] ? true : false
    token_duration_validity = sudo_mode ? 15.minutes : 1.month
    @token = @user.token(
      expiration: token_duration_validity.from_now,
      sudo: sudo_mode,
    )
  end
end
