json.pagination do
  json.per_page TransactionsController::PER_PAGE
  json.current_page @transactions.current_page
  json.total_pages @transactions.total_pages
end
json.totals do
  json.count @transactions.total_count
  json.debit @debit_sum
  json.credit @credit_sum
  json.difference @credit_sum - @debit_sum
end
json.transactions do
  json.array!(@transactions) do |transaction|
    json.id transaction.id
    json.title transaction.title
    json.amount transaction.amount
    json.date transaction.date
    json.note transaction.note
    json.kind transaction.kind
    json.category_id transaction.category_id
    json.user_id transaction.user_id
    json.currency transaction.currency
    json.category {
      json.id transaction.category.id
      json.title transaction.category.title
    }
  end
end