class AddDefaultToOrderProgress < ActiveRecord::Migration[8.0]
  def change
    change_column_default :orders, :progress, 0
  end
end
