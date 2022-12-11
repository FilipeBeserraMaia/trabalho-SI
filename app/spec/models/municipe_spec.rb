require 'rails_helper'

RSpec.describe Municipe, type: :model do

  subject(:municipe) { build(:municipe) }

  describe 'Presence validations' do
    it { should validate_presence_of(:nome) }
    it { should validate_presence_of(:cpf) }
    it { should validate_presence_of(:cns) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:dta_nasc) }
    it { should validate_presence_of(:telefone) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:foto) }
  end

  describe 'Length validations' do

    it { should validate_length_of(:nome).is_at_least(1).is_at_most(80) }
    it { should validate_length_of(:cpf).is_at_least(11).is_at_most(11) }
    it { should validate_length_of(:cns).is_at_least(15).is_at_most(15) }
    it { should validate_length_of(:email).is_at_least(1).is_at_most(256) }
    it { should validate_length_of(:telefone).is_at_least(13).is_at_most(13) }
  end

  describe 'CPF validations' do
    context ' When cpf is valid ' do
      it 'should be valid' do
        municipe.cpf = CPF.generate
        expect(municipe).to be_valid
      end
    end

    context ' When cpf is not  valid ' do
      it 'should be invalid' do
        municipe.cpf = CPF.generate.split('').shuffle.join.reverse.split('').shuffle.join.reverse
        expect(municipe).to be_invalid
      end
    end
  end
  #  :validate_nacimento

  describe 'Email validations' do
    context ' When email is valid ' do
      it 'should be valid' do
        municipe.email = Faker::Internet.email(name: Faker::Name.name)
        expect(municipe).to be_valid
      end
    end

    context ' When Email is not  valid ' do
      it 'should be invalid' do
        municipe.email = Faker::Lorem.words.join('').first(256)
        expect(municipe).to be_invalid
      end
    end
  end

  describe 'CNS validations' do
    context ' When CNS is valid ' do
      it 'should be valid' do
        municipe.cns = ['285577437360001', '176740668610018', '777915732900009'].sample
        expect(municipe).to be_valid
      end
    end

    context ' When CNS is not  valid ' do
      it 'should be invalid' do
        municipe.cns = Faker::Number.number(digits: 15).to_s.split('').shuffle.join.reverse
        expect(municipe).to be_invalid
      end
    end
  end

  describe 'dta_nasc validations' do
    context ' When dta_nasc is valid ' do
      it 'should be valid' do
        municipe.dta_nasc = Faker::Date.birthday(min_age: 18, max_age: 65)
        expect(municipe).to be_valid
      end
    end

    context ' When dta_nasc is not  valid ' do
      it 'should be invalid' do
        municipe.dta_nasc = Faker::Date.birthday(min_age: 150, max_age: 200)
        expect(municipe).to be_invalid
      end
    end
  end

end