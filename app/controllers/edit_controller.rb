require 'httparty'
require 'ostruct'

class EditController < ApplicationController
  before_action :require_login

  def edit
    response = NodeTaskService.get_task(params[:id])
    if response.success?
      @tarefa = JSON.parse(response.body)[0]
    else
      redirect_to home_path, notice: 'Failed to retrieve task.'
    end
  end

  def update
    tarefa_params = {
      name: params[:name],
      description: params[:description],
      priority: params[:priority],
      isEnded: params[:isEnded]
    }
    response = NodeTaskService.update_task(params[:id], tarefa_params)
    if response.success?
      redirect_to home_path, notice: 'Task was successfully updated.'
    else
      flash.now[:alert] = 'Failed to update task. Please try again.'
      render :edit
    end
  end

  def updatedatetime
    tarefa_params = {
      isEnded: "true",
      due_date: Time.now
    }
    response = NodeTaskService.update_task(params[:id], tarefa_params)
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


  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: 'You must be logged in to access this page.'
    end
  end
end
