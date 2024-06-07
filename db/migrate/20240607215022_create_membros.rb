class CreateMembros < ActiveRecord::Migration[7.1]
  def change
    create_table :membros do |t|
      t.string :name
      t.string :senha
      t.string :email

      t.timestamps
    end
  end
end
