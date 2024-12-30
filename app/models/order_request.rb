class OrderRequest < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :delivery_address, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :product_id, :quantity, :delivery_address, :first_name, :last_name, presence: true
end