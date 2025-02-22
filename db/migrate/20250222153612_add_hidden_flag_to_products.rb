class AddHiddenFlagToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :hidden, :boolean, default: false
  end
end
