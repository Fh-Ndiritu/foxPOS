class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :image, presence: true
  has_one_attached :image do |attachable|
    attachable.variant :icon, resize_to_fill: [ 64, 64 ]
    attachable.variant :thumb, resize_to_fill: [ 256, 256 ]
  end

  default_scope { order(:name) }

  scope :inactive, -> { where(active: false) }
  scope :active, -> { where(active: true) }

  scope :active_with_active_products, -> {
    active.select { |category| category.products.active_and_available.any? }
  }
end
