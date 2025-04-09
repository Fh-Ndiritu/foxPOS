class AddStockToProduct < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :stock, :integer, default: 0
    add_column :products, :availability, :integer, default: 0
  end
end
