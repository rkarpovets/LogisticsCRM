class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.string :contact_number
      t.string :address

      t.timestamps
    end
  end
end
