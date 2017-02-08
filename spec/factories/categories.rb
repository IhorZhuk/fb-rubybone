FactoryGirl.define do
  factory :category do
    title { Faker::Cat.name }
    user
  end
end
