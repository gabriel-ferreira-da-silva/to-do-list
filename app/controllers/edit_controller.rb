require 'httparty'

class EditController < ApplicationController
  before_action :require_login
  def edit
    response = NodeTaskService.get_task(params[:id])
    if response.success?
      @tarefa = JSON.parse(response.body)[0]
    else
      redirect_to home_path, notice: 'Task was successfully updated.'
    end
  end

  def update
    task_params = {
      name: params[:tarefa][:name],
      description: params[:tarefa][:description],
      priority: params[:tarefa][:priority],
      isEnded: params[:tarefa][:isEnded]
    }

    response = NodeTaskService.update_task(params[:id], task_params)

    if response.success?
      redirect_to home_path, notice: 'Task was successfully updated.'
    else
      flash.now[:alert] = 'Failed to update task. Please try again.'
      render :edit
    end
  end

  def destroy
    response = NodeTaskService.delete_task(params[:id])

    if response.success?
      redirect_to home_path, notice: 'Task was successfully deleted.'
    else
      flash.now[:alert] = 'Failed to delete task. Please try again.'
      redirect_to home_path
    end
  end

  private

  def tarefa_params
    params.require(:tarefa).permit(:name, :description, :isEnded, :priority,:membro)
  end

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: 'You must be logged in to access this page.'
    end
  end

end
