class ChangeVehicleIdNullableInDrivers < ActiveRecord::Migration[8.0]
  def change
    change_column_null :drivers, :vehicle_id, true
  end
end