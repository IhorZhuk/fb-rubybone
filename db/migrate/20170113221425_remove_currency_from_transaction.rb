class RemoveCurrencyFromTransaction < ActiveRecord::Migration[5.0]
  def change
     remove_column :transactions, :currency
  end
end
