class HomeController < ApplicationController

  before_action :require_login

  def index
    # Home page content
    @membro = Membro.find(session[:user_id])
    @membro_name = Membro.find(session[:user_id]).name
    @tarefas=Tarefa.where(membro: @membro.id)
  end



  private

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: 'You must be logged in to access this page.'
    end
  end

end
