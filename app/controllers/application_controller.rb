class ApplicationController < ActionController::Base
  helper_method :current_user
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def index
  end

  def login
    token = flash[:google_sign_in]["id_token"]
    email = GoogleSignIn::Identity.new(token).email_address
    session[:user_id] = User.find_or_create_by(email: email).id
    redirect_to "/"
  end

  def logout
    session.delete(:user_id)
    redirect_to "/"
  end
end