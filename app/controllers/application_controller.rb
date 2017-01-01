class ApplicationController < ActionController::API
  def client
    render file: 'public/index.html'
  end

protected

  def render_error(message, status = :bad_request)
    @message = message
    render 'api/errors/error', status: status
  end
end
