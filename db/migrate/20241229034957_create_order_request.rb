class CreateOrderRequest < ActiveRecord::Migration[8.0]
  def change
    create_table :order_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.string :delivery_address
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.string :status, default: "Pending"
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
