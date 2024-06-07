class HomeController < ApplicationController
  def index
  end

  before_action :require_login

  def index
    # Home page content
  end

  private

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: 'You must be logged in to access this page.'
    end
  end

end
