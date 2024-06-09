class Membro < ApplicationRecord
  validates :name, :senha, :email, presence: true
  validates :email, uniqueness: true
  validates_length_of :nome, minimum: 5, message: "nome deve ter ao menos 5 caracteres"
  validates_length_of :senha, minimum: 3, message: "nome deve ter ao menos 5 caracteres"

end
