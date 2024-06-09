class CadastroController < ApplicationController
  before_action :require_login
  before_action :require_login
  def index
  end
  def new
    @membro = Membro.new
  end

  def listmembros
    @membros=Membro.all
  end

  def editmembro
    @membro = Membro.find(session[:user_id])
  end

  def update_membro
    @membro = Membro.find(session[:user_id])
    @membro.update(membro_params)
    redirect_to listmembros_path
  end

  def delete_membro
    @membro = Membro.find(session[:user_id])
    @tarefas = Tarefa.where(membro: @membro.name)
    @tarefas.destroy_all
    @membro.destroy
    redirect_to login_path
  end

  def create
    @membro = Membro.new(membro_params)

    if @membro.save
      redirect_to home_path, notice: 'mebro was successfully created.'
    else
      render :new
    end
  end

  private

  def membro_params
    params.require(:membro).permit(:name, :email, :senha)
  end
end
