class Order < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :products, through: :items
  default_scope { order(created_at: :desc, progress: :asc) }
  scope :in_process, -> { where(progress: [ :kitchen, :ready, :served, :payment ]) }

  def recompute_cost
    subtotal =  items.sum { |item| item.quantity * item.product.price }
    tax = subtotal.to_f * 0.16   # update to dynamic rates
    update(
      subtotal: subtotal,
      tax: tax,
      total:  subtotal + tax
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
