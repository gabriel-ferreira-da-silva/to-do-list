class HomeController < ApplicationController
  before_action :require_login

  def index
    user_response = NodeUserService.fetch_user(session[:user_id])
    if user_response.is_a?(Net::HTTPSuccess)
      @membro = JSON.parse(user_response.body)
      @membro_name = @membro[0]['name']
    else
      redirect_to login_path, alert: 'Failed to fetch user data. Please try again.'
      return
    end

    tasks_response = NodeTaskService.fetch_tasks_byuser(session[:user_id])
    if tasks_response.is_a?(Net::HTTPSuccess)
      @tarefas = JSON.parse(tasks_response.body)
    else
      @tarefas = []
      flash.now[:alert] = 'Failed to fetch tasks. Displaying empty task list.'
    end
  end

  private

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: 'You must be logged in to access this page.'
    end
  end
end
