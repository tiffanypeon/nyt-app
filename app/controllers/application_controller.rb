class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :filter_request

  private

  def filter_request
    if !request.get?
      render status: 403, body: 'forbidden request'
    end
  end
end
