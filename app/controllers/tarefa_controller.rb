class TarefaController < ApplicationController
  def index
    @tarefas = Tarefa.all
  end

  def new
    @tarefa = Tarefa.new
  end

  def create
    @tarefa = Tarefa.new(tarefa_params)
    if @Tarefa.save
      redirect_to @tarefa, notice: 'tarefa was successfully created.'
    else
      render :new
    end
  end

  private

  def tareafa_params
    params.require(:project).permit(:membro, :nome, :descricao, :prioridade, :finalizada)
  end

end
