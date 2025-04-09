class SetProductDefaults < ActiveRecord::Migration[8.0]
  def change
    change_column_default :products, :active, from: nil, to: true
    change_column_default :products, :availability, from: 0, to: 1
    change_column_default :products, :stock, from: nil, to: 10
    change_column_default :products, :size, from: nil, to: "Small"
  end
end
