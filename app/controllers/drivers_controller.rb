class DriversController < ApplicationController
  before_action :set_driver, only: [:show, :edit, :update, :destroy]

  def index
    @drivers = Driver.all
  end

  def new
    @driver = Driver.new
    @available_vehicles = find_available_vehicles
  end

  def edit
    @available_vehicles = find_available_vehicles.to_a
    @available_vehicles = [@driver.vehicle].compact + @available_vehicles if @driver.vehicle
  end

  def create
    @driver = Driver.new(driver_params)
    @available_vehicles = find_available_vehicles

    if @driver.save
      redirect_to drivers_path
    else
      render :new
    end
  end

  def update
    if @driver.update driver_params
      redirect_to drivers_path
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @driver.destroy
    redirect_to drivers_path
  end

  private

  def driver_params
    params.require(:driver).permit(:name, :surname, :contact_number, :email, :vehicle_id)
  end


  def set_driver
    @driver = Driver.find(params[:id])
  end

  def find_available_vehicles
    Vehicle.left_outer_joins(:driver).where(drivers: { id: nil })
  end
end