class Order < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :products, through: :items
  default_scope { order(created_at: :desc, progress: :asc) }
  scope :in_process, -> { where(progress: [ :kitchen, :ready, :served, :payment ]) }

  def recompute_cost
    subtotal =  items.sum { |item| item.quantity * item.product.price }
    total = subtotal
    tax = total.to_f * 0.16   # update to dynamic rates
    subtotal = total-tax
    update(
      subtotal:,
      tax:,
      total:
    )
  end

  enum :progress, {
    pending: 0,
    kitchen: 1,
    ready: 2,
    served: 3,
    payment: 4,
    complete: 5
  }

  def pre_serving?
    ready? || kitchen?
  end

  def server_name
    ""
  end
end
