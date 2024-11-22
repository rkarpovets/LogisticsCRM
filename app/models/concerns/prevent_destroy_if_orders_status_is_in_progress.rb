module PreventDestroyIfOrdersStatusIsInProgress
  extend ActiveSupport::Concern

  included do
    before_destroy :prevent_destroy, if: :orders_status_is_in_progress?
  end

  private

  def prevent_destroy
    errors.add(:base, "Can't destroy while order is in progress.")
    throw(:abort)
  end

  def orders_status_is_in_progress?
    true if self.orders.exists?(status: 'in_progress')
  end
end