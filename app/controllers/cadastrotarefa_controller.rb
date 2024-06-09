class CadastrotarefaController < ApplicationController
  before_action :require_login
  def new
    @tarefa = Tarefa.new
  end

  def create
    @tarefa = Tarefa.new(tarefa_params)
    @membro = Membro.find(session[:user_id])
    if @tarefa.save
      redirect_to home_path, notice: 'Tarefa was successfully created.'
    else
      render :new
    end
    @tarefa.update(membro: @membro.id)
  end

  private

  def tarefa_params
    params.require(:tarefa).permit(:nome, :descricao, :membro, :finalizada, :prioridade)
  end
end
