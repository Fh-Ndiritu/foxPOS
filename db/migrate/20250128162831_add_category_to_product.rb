class AddCategoryToProduct < ActiveRecord::Migration[8.0]
  def change
    add_reference :products, :category, null: false, foreign_key: true
    add_column :products, :size, :string
  end
end
