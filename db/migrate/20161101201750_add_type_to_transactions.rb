class AddTypeToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :type, :string
  end
end
