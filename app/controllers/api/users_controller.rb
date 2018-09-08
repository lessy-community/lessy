class Api::UsersController < ApiController
  skip_before_action :require_login, only: [:create]
  skip_before_action :require_tos_accepted, only: %i[create show destroy accept_tos]

  before_action :require_registration_enabled, only: :create
  before_action only: :destroy do
    require_sudo if current_user.active?
  end

  def create
    @user = User.create!(create_user_params)
    @token = @user.token(expiration: 1.day.from_now)
    render status: :created
  end

  def show
    @user = current_user
  end

  def destroy
    current_user.destroy!
  end

  def accept_tos
    @user = current_user
    @user.update! terms_of_service: TermsOfService.current
  end

private

  def require_registration_enabled
    registration_disabled = !Flipper.enabled?(:feature_registration)
    render_error ApiErrors::RegistrationDisabled.new, :forbidden if registration_disabled
  end

  def create_user_params
    fetch_resource_params(:user, [:email])
      .merge(terms_of_service: TermsOfService.current)
  end
end
