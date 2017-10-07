class Api::Users::AuthorizationsController < ApiController

  skip_before_action :require_login, only: [:create]

  def create
    @user = User.authenticate(params[:username], params[:password])
    if @user
      @token = @user.token(1.month.from_now)
    else
      render_custom_error 'Bad credentials', :login_failed, User, :unauthorized
    end
  end

end
