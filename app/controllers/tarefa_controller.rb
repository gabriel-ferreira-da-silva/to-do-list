class TarefaController < ApplicationController
  def index
    @tarefas = Tarefa.all
  end
end
