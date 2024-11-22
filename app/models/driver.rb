class Driver < ApplicationRecord
  include PreventDestroyIfOrdersStatusIsInProgress

  validates :name, :surname, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :contact_number, presence: true, uniqueness: true

  belongs_to :vehicle, optional: true
  has_many :orders, dependent: :nullify
end
