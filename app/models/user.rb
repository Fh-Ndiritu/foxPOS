class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { admin: 0, manager: 1, staff: 2 }
  has_one_attached :avatar do |attachable|
    attachable.variant :icon, resize_to_fill: [64, 64]
    attachable.variant :thumb, resize_to_fill: [256, 256]
  end

  def can_manage?
    admin? || manager?
  end

  def age
    return unless birth_date.present?

    now = Time.now.utc.to_date
    now.year - birth_date.year - (now.month > birth_date.month || (now.month == birth_date.month && now.day >= birth_date.day) ? 0 : 1)
  end


end
