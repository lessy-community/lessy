class ApplicationController < ActionController::API
  def client
    render file: 'public/index.html'
  end
end
