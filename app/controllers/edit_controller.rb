class EditController < ApplicationController
  before_action :require_login
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

  def updatedatetime
    @tarefa = Tarefa.find(params[:id])
    @tarefa.update(data: Time.now)
    @tarefa.update(finalizada: "true")
    redirect_to home_path, notice: 'Datetime updated successfully.'
  end

  def destroy
    @tarefa = Tarefa.find(params[:id])
    @tarefa.destroy
    respond_to do |format|
      format.html { redirect_to home_path, notice: 'Tarefa was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def tarefa_params
    params.require(:tarefa).permit(:nome, :descricao, :finalizada, :prioridade,:membro)
  end

end
