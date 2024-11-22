class CreateVehicles < ActiveRecord::Migration[8.0]
  def change
    create_table :vehicles do |t|
      t.string :brand
      t.string :model
      t.integer :year
      t.string :vehicle_identification_number
      t.string :license_plate_number

      t.timestamps
    end
  end
end
