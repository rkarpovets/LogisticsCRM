class Customer < ApplicationRecord
  include PreventDestroyIfOrdersStatusIsInProgress

  validates :name, :surname, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :contact_number, uniqueness: true
  validates :address, presence: true

  has_many :orders, dependent: :nullify
end
