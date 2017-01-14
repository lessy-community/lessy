class Api::WelcomeController < ApplicationController

  skip_before_action :require_login

  def not_found
    render_error 'Endpoint does not exist', :not_found
  end

end
