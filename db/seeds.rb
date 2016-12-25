user_id = 5
category_id = 8

for i in (1..75)
  kind = ['credit', 'debit']

  Transaction.create!(
    user_id: user_id,
    date: Faker::Date.between(60.days.ago, Date.today), 
    title: Faker::Lorem.sentence(2), 
    amount: rand(10..1000), 
    kind: kind.sample, 
    currency: 'EUR', 
    note: Faker::Lorem.sentences.join(" "), 
    category_id: category_id
  )
end 
