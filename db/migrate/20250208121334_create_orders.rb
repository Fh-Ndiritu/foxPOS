class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.integer :progress
      t.string :items
      t.string :subtotal
      t.string :tax
      t.string :total

      t.timestamps
    end
  end
end
