class Product < ApplicationRecord
  belongs_to :category, counter_cache: true
  validates :image, :name, :price, :size, presence: true

  has_one_attached :image do |attachable|
    attachable.variant :icon, resize_to_fill: [ 64, 64 ]
    attachable.variant :thumb, resize_to_fill: [ 256, 256 ]
  end


  enum :availability, {
    in_stock: 1,
    out_of_stock: 0
  }

  default_scope { not_deleted.order(created_at: :desc) }

  scope :active_and_available, -> { in_stock.where(active: true, hidden: false).where("stock > ?", "0") }
  scope :deleted, -> { where(hidden: true) }
  scope :not_deleted, -> { where(hidden: false) }

  after_update_commit -> { broadcast_replace_to "products" }
  after_destroy -> { broadcast_remove_to "products" }

  def thumbnail
    image.variant(resize_to_fill: [ 200, 200 ]).processed
  end

  def destroy!
    update!(hidden: true)
  end
end
