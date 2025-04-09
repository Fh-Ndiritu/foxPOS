class AddProductsCountToCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :categories, :products_count, :integer, default: 0
  end
end
