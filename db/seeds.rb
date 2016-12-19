now = Time.new

Category.create!(title: Faker::Lorem.word)
Category.create!(title: Faker::Lorem.word)
Category.create!(title: Faker::Lorem.word)
Category.create!(title: Faker::Lorem.word)

for i in (1..30)
  kind = ['credit', 'debit']

  Transaction.create!(
    date: now, 
    title: Faker::Lorem.sentence(2), 
    amount: rand(10..1000), 
    kind: kind.sample, 
    currency: 'EUR', 
    note: Faker::Lorem.sentences.join(" "), 
    category_id: rand(1..4)
  )
end 
