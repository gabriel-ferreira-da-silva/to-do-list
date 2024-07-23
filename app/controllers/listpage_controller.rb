class ListpageController < ApplicationController
  before_action :require_login
  def index
    response = NodeTaskService.all_tasks

    if response.success?
      @tarefas = JSON.parse(response.body)
    else
      flash[:alert] = 'Failed to fetch users. Please try again.'
      @tarefas = []
    end
  end

  private

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: 'You must be logged in to access this page.'
    end
  end

end
