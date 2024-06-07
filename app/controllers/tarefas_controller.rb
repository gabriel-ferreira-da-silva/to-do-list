class TarefasController < ApplicationController
  def new
    @tarefa = Tarefa.new
  end

  def create
    @tarefa = Tarefa.new(tarefa_params)

    if @tarefa.save
      redirect_to new_tarefa_path, notice: 'Tarefa was successfully created.'
    else
      render :new
    end
  end

  private

  def tarefa_params
    params.require(:tarefa).permit(:nome, :descricao, :membro, :finalizada, :prioridade)
  end
end
