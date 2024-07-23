require 'httparty'

require_dependency 'node_user_service'

class CadastroController < ApplicationController
  before_action :require_login

  def index

  end

  def new
  end

  def listmembros

  end



  def update_membro

  end

  def delete_membro

  end

  def create
    membro_params = {
      name: params[:name],
      password: params[:password],
      email: params[:email],
    }

    response = NodeUserService.create_user(membro_params)
    puts membro_params

    if response.success?
      redirect_to home_path, notice: 'user was successfully created.'
    else
      puts "\n\n\n something wnet wrong\n\n\n"
      flash.now[:alert] = 'Failed to create tarefa. Please try again.'
      render :new
    end
  end

  private

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: 'You must be logged in to access this page.'
    end
  end
end
