user_id = 1
category_id = 1

for i in (1..55)
  kind = ['credit', 'debit']

  Transaction.create!(
    user_id: user_id,
    date: Faker::Date.between(35.days.ago, Date.today), 
    title: Faker::Lorem.sentence(2), 
    amount: rand(10..1000), 
    kind: kind.sample, 
    note: Faker::Lorem.sentences.join(" "), 
    category_id: category_id
  )
end 
