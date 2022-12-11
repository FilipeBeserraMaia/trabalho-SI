require 'factory_bot'

FactoryBot.define do
  factory :municipe do
    nome { Faker::Name.name }
    cpf { CPF.generate }
    cns { ['285577437360001', '176740668610018', '777915732900009'].sample }
    email { Faker::Internet.email(name: nome) }
    dta_nasc { Faker::Date.birthday(min_age: 18, max_age: 65) }
    telefone { Utility.phone_br_stripped(Faker::PhoneNumber.cell_phone_with_country_code) }
    status { Municipe.statuses.keys.sample }
    foto { Rack::Test::UploadedFile.new("#{Rails.root}/app/assets/images/to_rspec_test.png") }
  end
end