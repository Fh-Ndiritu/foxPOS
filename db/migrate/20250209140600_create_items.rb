class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.belongs_to :order, null: false, foreign_key: true
      t.belongs_to :product, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 1
      t.integer :price

      t.timestamps
    end
  end
end
