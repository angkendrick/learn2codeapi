class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session

  skip_before_filter :verify_authenticity_token

  protected


  def require_login
    authenticate_or_request_with_http_token do |token, options|
     User.find_by(token: token)
    end
  end

  def get_id
    authenticate_or_request_with_http_token do |token, options|
      user = User.find_by(token: token)
      user.id if user
    end
  end

end
