class Renamedescricao < ActiveRecord::Migration[7.1]
  def change
    remove_column :tarefas, :decricao, :string
    add_column :tarefas, :descricao, :string
  end
end
