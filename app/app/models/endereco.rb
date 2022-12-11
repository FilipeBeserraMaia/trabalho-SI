class Endereco < ApplicationRecord
  belongs_to :municipe
  validates_presence_of :cep, :longr, :bairro, :cidade, :uf

  validates_length_of :cep, minimum: 8, maximum: 8
  validates_length_of :longr, minimum: 1, maximum: 50
  validates_length_of :complemento, minimum: 0, maximum: 50
  validates_length_of :bairro, minimum: 1, maximum: 80
  validates_length_of :cidade, minimum: 1, maximum: 30
  validates_length_of :uf, minimum: 2, maximum: 2
  validates_length_of :cdg_ibge, minimum: 0, maximum: 7

end