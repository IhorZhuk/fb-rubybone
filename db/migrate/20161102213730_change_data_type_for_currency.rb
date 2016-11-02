class ChangeDataTypeForCurrency < ActiveRecord::Migration[5.0]
  def self.up
    change_table :transactions do |t|
      t.change :currency, :string
    end
  end
  def self.down
    change_table :transactions do |t|
      t.change :currency, :integer
    end
  end
end
