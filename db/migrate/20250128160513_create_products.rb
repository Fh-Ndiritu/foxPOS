class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.float :price
      t.boolean :active

      t.timestamps
    end
  end
end
