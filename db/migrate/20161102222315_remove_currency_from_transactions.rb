class RemoveCurrencyFromTransactions < ActiveRecord::Migration[5.0]

  def self.up
    remove_column :transactions, :currency
  end

  def self.down
    add_column :transactions, :currency, :string
  end
end
