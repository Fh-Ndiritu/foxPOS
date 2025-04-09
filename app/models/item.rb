class Item < ApplicationRecord
  belongs_to :order
  belongs_to :product
  delegate :name, to: :product

  def increment_quantity
    return false if quantity >= product.stock

    increment!(:quantity)
    true
  end

  def decrement_quantity
      decrement!(:quantity)
  end

  def price
    quantity * product.price
  end
end
