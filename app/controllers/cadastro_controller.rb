require 'httparty'
require 'net/http'
require 'json'


require_dependency 'node_user_service'

class CadastroController < ApplicationController
  before_action :require_login

  def index

  end

  def listmembros
    user_response = NodeUserService.all_users

    if user_response.success?
      @membros = JSON.parse(user_response.body)
    else
      flash[:alert] = 'Failed to fetch users. Please try again.'
      @membros = []
    end
  end

  def new
    user_id = params[:user_id]
    user_response = NodeUserService.get_user(user_id)

    if user_response.success?
      @membro = JSON.parse(user_response.body)
    else
      flash[:alert] = 'Failed to fetch user details. Please try again.'
      redirect_to listmembros_path
    end
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

  def update_membro
    membro_params = {
      name: params[:name],
      password: params[:password],
      email: params[:email],
    }

    response = NodeUserService.update_user(session[:user_id], membro_params)
    puts membro_params

    if response.success?
      redirect_to home_path, notice: 'user was successfully created.'
    else
      puts "\n\n\n something wnet wrong\n\n\n"
      flash.now[:alert] = 'Failed to create tarefa. Please try again.'
      render :new
    end
  end
  def delete_membro

    response = NodeTaskService.delete_task_byuser(session[:user_id])
    response = NodeUserService.delete_user(session[:user_id])

    if response.success?
      redirect_to login_path, notice: 'user was successfully created.'
    else
      puts "\n\n\n something wnet wrong\n\n\n"
      flash.now[:alert] = 'Failed to create tarefa. Please try again.'
      render :new
    end
  end

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: 'You must be logged in to access this page.'
    end
  end
end
