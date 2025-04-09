class AddRoleToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :integer, default: 3
  end
end
