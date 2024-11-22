class Product < ApplicationRecord
  validates :name, :description, presence: true
  validates :available_quantity, :numericality => { :greater_than => 0, message: "Available quantity must be greater than 0." }, presence: true

  has_many :orders, dependent: :nullify

  after_update :update_orders_total_price, if: :saved_change_to_unit_price?

  before_update :prevent_change_available_quantity, if: :saved_change_to_available_quantity?

  before_destroy :prevent_destroy, if: :product_in_stock?

  private

  def update_orders_total_price
    orders.find_each do |order|
      order.update(total_price: self.unit_price * order.quantity)
    end
  end

  def product_in_stock?
    true if self.available_quantity > 0
  end

  def prevent_change_available_quantity
    errors.add(:available_quantity, "Can't change quantity of a product.")
    throw(:abort)
  end

  def prevent_destroy
    errors.add(:available_quantity, "Can't delete product if in stock.")
    throw(:abort)
  end
end
