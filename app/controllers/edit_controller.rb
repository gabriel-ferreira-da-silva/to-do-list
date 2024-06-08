class EditController < ApplicationController
  def index
    @tarefas=Tarefa.all
  end
end
