class AddStatusToCategory < ActiveRecord::Migration[8.0]
  def change
    add_column :categories, :status, :integer, default: 1
  end
end
