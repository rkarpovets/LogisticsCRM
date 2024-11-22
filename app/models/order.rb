class Order < ApplicationRecord
  STATUSES = ["Pending", "In progress", "Completed", "Canceled"]

  validates :customer, presence: true
  validates :product, presence: true
  validates :driver, presence: true
  validates :quantity, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES, message: "%{value} is not a valid status." }

  validate :validate_quantity

  belongs_to :customer
  belongs_to :product
  belongs_to :driver

  after_commit :set_tracking_number, :on => :create
  after_commit :set_status, :on => :create

  before_create :decrease_product_available_quantity
  before_create :formatted_created_at

  before_update :prevent_update, if: :status_is_in_progress?
  before_update :handle_quantity_change, if: :quantity_changed?

  before_save :set_total_price

  before_destroy :prevent_destroy, if: :status_is_in_progress?
  before_destroy :return_quantity_to_product, if: :status_is_in_canceled?

  def formatted_created_at
    created_at.in_time_zone("Europe/Kyiv").strftime("%d.%m.%Y %H:%M")
  end

  private

  def decrease_product_available_quantity
    product.update(available_quantity: product.available_quantity - self.quantity)
  end

  def set_total_price
    self.total_price = product.unit_price * self.quantity
  end

  def set_tracking_number
    update_column(:tracking_number, generate_tracking_number)
  end

  def set_status
    update_column(:status, STATUSES.first.to_s)
  end

  def generate_tracking_number
    "MDN#{self.id.to_s.rjust(6, '0')}"
  end

  def status_is_in_progress?
    true if self.status == "In progress"
  end

  def status_is_in_canceled?
    true if self.status == "Canceled"
  end

  def prevent_update
    errors.add(:status, "Can't update info while order is in progress.")
    throw(:abort)
  end

  def prevent_destroy
    errors.add(:status, "Can't destroy while order is in progress.")
    throw(:abort)
  end

  def return_quantity_to_product
    product.update(available_quantity: product.available_quantity + self.quantity)
  end

  def handle_quantity_change
    product.update(available_quantity: product.available_quantity + self.quantity_was - self.quantity)
  end

  def validate_quantity
    if self.quantity <= 0
      errors.add(:quantity, "Quantity must be greater than 0.")
    elsif self.quantity > product.available_quantity
      errors.add(:quantity, "Quantity can't be greater than available quantity. #{product.available_quantity} units of #{product.name.downcase} left in stock.")
    end
  end
end
