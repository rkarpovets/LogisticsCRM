class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :tracking_number
      t.references :customer, null: true, foreign_key: true
      t.references :product, null: true, foreign_key: true
      t.references :driver, null: true, foreign_key: true
      t.integer :quantity
      t.decimal :total_price, precision: 10, scale: 2
      t.string :status

      t.timestamps
    end
  end
end
