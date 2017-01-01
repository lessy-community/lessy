class ApplicationController < ActionController::API
  def client
    render file: 'public/index.html'
  end

protected

  def render_error(message)
    @message = message
    render 'api/errors/error', status: :bad_request
  end
end
