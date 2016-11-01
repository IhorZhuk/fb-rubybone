class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :title
      t.float :amount
      t.date :date
      t.integer :currency
      t.string :note

      t.timestamps
    end
  end
end
