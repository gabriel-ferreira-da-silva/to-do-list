class Tarefa < ApplicationRecord
  validates :nome, :descricao, :finalizada, :prioridade, :membro, presence: true

  validates :prioridade, inclusion: { in: %w(baixa media alta), message: "%{value} is not a valid priority" }
  validates :finalizada, inclusion: { in: %w(true false), message: "%{value} is not a valid final atribution" }

  validates_length_of :nome, maximum: 50, minimum: 5, message: "nome deve ter entre 5 e 50 caracteres"
  validates_length_of :descricao, maximum: 140, message: "descricao deve ter no maximo 140 caracters"

end
