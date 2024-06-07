class LoginController < ApplicationController
  def index
  end

  def new
    # Render the login form
  end

  def create
    user = Membro.find_by(name: params[:name])

    if user && user.senha == params[:senha]
      session[:user_id] = user.id
      redirect_to home_path, notice: 'Logged in successfully.'
    else
      flash.now[:alert] = 'Invalid name or password.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'Logged out successfully.'
  end
end
