FactoryGirl.define do
  factory :transaction do
    title { Faker::Lorem.word }
    amount { Faker::Number.decimal(2) }
    date { Faker::Date.backward }
    note { Faker::Lorem.words.join(' ') }
    kind { %w(debit credit).sample }
    category
    user
  end
end