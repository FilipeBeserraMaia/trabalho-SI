require 'factory_bot'

FactoryBot.define do
  factory :endereco do
    cep { Faker::Number.number(digits: 8).to_s }
    longr { Faker::Address.street_address.to_s }
    bairro { Faker::Address.city }
    cidade { Faker::Address.city }
    uf { Faker::Number.number(digits: 2).to_s }
    complemento { Faker::Number.number(digits: 50).to_s }
    cdg_ibge { Faker::Number.number(digits: 7).to_s }
  end
end