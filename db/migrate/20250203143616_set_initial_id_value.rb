class SetInitialIdValue < ActiveRecord::Migration[6.1]
  def up
    execute "ALTER SEQUENCE products_id_seq RESTART WITH 999999999"
  end

  def down
    execute "ALTER SEQUENCE products_id_seq RESTART WITH 1"
  end
end
