class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :image, presence: true

  default_scope { order(:name) }

  scope :inactive, -> { where(active: false) }
  scope :active, -> { where(active: true) }

scope :active_with_active_products, -> {
  active.select { |category| category.products.active_and_available.any? }
}
end
