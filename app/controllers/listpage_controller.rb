class ListpageController < ApplicationController
  def index
    @tarefas=Tarefa.all
  end
end
