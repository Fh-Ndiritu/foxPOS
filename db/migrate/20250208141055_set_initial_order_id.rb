class SetInitialOrderId < ActiveRecord::Migration[8.0]
  def up
    execute "ALTER SEQUENCE orders_id_seq RESTART WITH 999999"
  end

  def down
    execute "ALTER SEQUENCE orders_id_seq RESTART WITH 1"
  end
end
