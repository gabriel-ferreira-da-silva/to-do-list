class EditController < ApplicationController

  def edit
    @tarefa = Tarefa.find([params[:id]])
  end

  def update
    @tarefa = Tarefa.find(params[:id])
    if @tarefa.update(tarefa_params)
      redirect_to home_path, notice: 'Task was successfully updated.'
    else
      render :new
    end
  end

  private

  def tarefa_params
    params.require(:tarefa).permit(:nome, :descricao, :finalizada, :prioridade,:membro)
  end

end
