class Vehicle < ApplicationRecord
  include PreventDestroyIfOrdersStatusIsInProgress

  validates :brand, presence: true
  validates :model, presence: true
  validates :year, presence: true
  validates :vehicle_identification_number, presence: true, uniqueness: true
  validates :license_plate_number, presence: true, uniqueness: true

  has_one :driver, required: false, dependent: :nullify
  has_many :orders, through: :driver, dependent: :nullify
end
