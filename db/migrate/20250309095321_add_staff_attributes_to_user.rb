class AddStaffAttributesToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :full_name, :string
    add_column :users, :phone, :string
    add_column :users, :birth_date, :date, default: '2000-01-01'
    add_column :users, :salary, :integer

    add_column :users, :shift_start, :time, default: '08:00:00'
    add_column :users, :shift_end, :time, default: '21:00:00'
    add_column :users, :hidden, :boolean, default: false
  end
end
