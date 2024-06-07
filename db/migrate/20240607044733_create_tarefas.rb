class CreateTarefas < ActiveRecord::Migration[7.1]
  def change
    create_table :tarefas do |t|
      t.string :nome
      t.string :decricao
      t.string :finalizada
      t.string :data
      t.string :prioridade

      t.timestamps
    end
  end
end
