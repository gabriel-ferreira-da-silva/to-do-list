require 'httparty'

class CadastrotarefaController < ApplicationController
  before_action :require_login

  def new

  end

  def create
    tarefa_params = {
      name: params[:name],
      description: params[:description],
      user_id: session[:user_id],
      isEnded: "false",
      priority: params[:priority]
    }

    response = NodeTaskService.create_task(tarefa_params)
    puts tarefa_params

    if response.success?
      redirect_to home_path, notice: 'Tarefa was successfully created.'
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
