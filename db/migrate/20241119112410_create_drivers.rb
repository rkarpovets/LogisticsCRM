class CreateDrivers < ActiveRecord::Migration[8.0]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.string :contact_number
      t.references :vehicle, null: true, foreign_key: true

      t.timestamps
    end
  end
end
