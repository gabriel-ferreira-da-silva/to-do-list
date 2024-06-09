class ListpageController < ApplicationController
  before_action :require_login
  def index
    @tarefas=Tarefa.all
    @membros = Membro.all
  end
end
