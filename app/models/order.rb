class Order < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :products, through: :items
  default_scope { order(created_at: :desc, progress: :asc) }
  scope :in_process, -> { where(progress: [ :kitchen, :ready, :served ]) }

  def recompute_cost
    # we shall remove tax logic so that total and subtotal are the same
    total =  items.sum { |item| item.quantity * item.product.price }
    update(
      subtotal: total,
      tax: 0,
      total:
    )
  end

  enum :progress, {
    pending: 0,
    kitchen: 1,
    ready: 2,
    served: 3,
    complete: 5
  }

  def pre_serving?
    ready? || kitchen?
  end

  def server_name
    ""
  end
end
