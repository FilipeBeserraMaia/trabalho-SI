require 'rails_helper'

RSpec.describe Endereco, type: :model do

  subject(:endereco) { build(:endereco) }

  describe 'Presence validations' do
    it { should validate_presence_of(:cep) }
    it { should validate_presence_of(:longr) }
    it { should validate_presence_of(:bairro) }
    it { should validate_presence_of(:cidade) }
    it { should validate_presence_of(:uf) }
  end

  describe 'Length validations' do
    it { should validate_length_of(:cep).is_at_least(8).is_at_most(8) }
    it { should validate_length_of(:longr).is_at_least(1).is_at_most(50) }
    it { should validate_length_of(:complemento).is_at_least(0).is_at_most(50) }
    it { should validate_length_of(:bairro).is_at_least(1).is_at_most(80) }
    it { should validate_length_of(:cidade).is_at_least(1).is_at_most(30) }
    it { should validate_length_of(:uf).is_at_least(2).is_at_most(2) }
    it { should validate_length_of(:cdg_ibge).is_at_least(0).is_at_most(7) }
  end

end