class CreateCurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :currencies do |t|
      t.integer :user_id
      t.string :title

      t.timestamps
    end
  end
end
