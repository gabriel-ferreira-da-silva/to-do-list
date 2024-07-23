require 'net/http'
require 'json'

class LoginController < ApplicationController
  def index
  end

  def new

  end

  def create
    response = NodeUserService.authenticate_user(login_params)
    user_data = JSON.parse(response.body)

    if response.code.to_i == 200 && user_data['valid']
      session[:user_id] = user_data['id']
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

  private

  def login_params
    params.permit(:name, :senha)
  end
end
