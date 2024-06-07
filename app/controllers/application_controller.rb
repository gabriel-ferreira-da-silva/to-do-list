class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def current_user
    @current_user ||= Membro.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      flash[:alert] = 'You must be logged in to access this section'
      redirect_to login_path
    end
  end
end
