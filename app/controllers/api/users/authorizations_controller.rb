class Api::Users::AuthorizationsController < ApiController
  skip_before_action :require_login, only: [:create]
  skip_before_action :require_tos_accepted, only: [:create]

  def create
    @user = User.authenticate(params[:username], params[:password])
    unless @user
      render_error ApiErrors::LoginFailed.new, :unauthorized
      return
    end
    @token = @user.token(expiration: 1.month.from_now)
  end
end
