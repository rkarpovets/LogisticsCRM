class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :available_quantity
      t.decimal :unit_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
