class VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]

  def index
    @vehicles = Vehicle.all
  end

  def new
    @vehicle = Vehicle.new
    @available_drivers = find_available_drivers
  end

  def edit
    @available_drivers = find_available_drivers
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    @available_drivers = find_available_drivers

    if @vehicle.save
      redirect_to vehicles_path
    else
      render :new
    end
  end

  def update
    if @vehicle.update vehicle_params
      redirect_to vehicles_path
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @vehicle.destroy
    redirect_to vehicles_path
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:brand, :model, :year, :vehicle_identification_number, :license_plate_number)
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def find_available_drivers
    Driver.left_outer_joins(:vehicle).where(vehicles: { id: nil })
  end
end