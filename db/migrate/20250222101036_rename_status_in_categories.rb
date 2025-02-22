class RenameStatusInCategories < ActiveRecord::Migration[8.0]
  def change
    remove_column :categories, :status, :string
    add_column :categories, :active, :boolean, default: true
  end
end
