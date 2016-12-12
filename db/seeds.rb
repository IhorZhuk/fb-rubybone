now = Time.new

Category.create!(title: 'Uncategorized')

Transaction.create!(date: now, title: 'Dummy transaction title', amount: 10.5, kind: 'debit', currency: 'EUR', note: 'Dummy transaction note lorem ipsum dolor sit ammet', category_id: 1)
Transaction.create!(date: now, title: 'Dummy transaction title', amount: 1200, kind: 'credit', currency: 'EUR', note: 'Dummy transaction note lorem ipsum dolor sit ammet', category_id: 1)
Transaction.create!(date: now, title: 'Dummy transaction title', amount: 70.5, kind: 'debit', currency: 'EUR', note: 'Dummy transaction note lorem ipsum dolor sit ammet',  category_id: 1)