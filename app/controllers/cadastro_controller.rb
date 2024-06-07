class CadastroController < ApplicationController
  before_action :require_login
  def index
  end
  def new
    @membro = Membro.new
  end

  def create
    @membro = Membro.new(membro_params)

    if @membro.save
      redirect_to new_cadastro_path, notice: 'mebro was successfully created.'
    else
      render :new
    end
  end

  private

  def membro_params
    params.require(:membro).permit(:name, :email, :senha)
  end
end
