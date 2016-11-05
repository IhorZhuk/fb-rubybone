# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Transaction.create!(date: '2016-11-05', title: 'Dummy transaction title', amount: 10.5, kind: 'debit', currency: 'EUR', note: 'Dummy transaction note lorem ipsum dolor sit ammet')
Transaction.create!(date: '2016-11-05', title: 'Dummy transaction title', amount: 1200, kind: 'credit', currency: 'EUR', note: 'Dummy transaction note lorem ipsum dolor sit ammet')
Transaction.create!(date: '2016-11-05', title: 'Dummy transaction title', amount: 70.5, kind: 'debit', currency: 'EUR', note: 'Dummy transaction note lorem ipsum dolor sit ammet')