class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { super_admin: 0, admin: 1, manager: 2, staff: 3 }
  has_one_attached :avatar do |attachable|
    attachable.variant :icon, resize_to_fill: [ 64, 64 ]
    attachable.variant :thumb, resize_to_fill: [ 256, 256 ]
  end

  default_scope { where(hidden: false).order(role: :asc) }

  def can_manage?
    super_admin? || admin?
  end

  def manageable_users
    User.where("role > ?", role_before_type_cast)
  end

  def age
    return unless birth_date.present?

    now = Time.now.utc.to_date
    now.year - birth_date.year - (now.month > birth_date.month || (now.month == birth_date.month && now.day >= birth_date.day) ? 0 : 1)
  end

  def orders
    # TODO ensure orders belong to user
    [ 1 ]*rand(1..10)
  end


  def generate_reset_password_token
    raw_token, encrypted_token = Devise.token_generator.generate(self.class, :reset_password_token)
    update!(
      reset_password_token: encrypted_token,
      reset_password_sent_at: Time.now
    )
    raw_token
  end

  def reset_password_token_valid?
    reset_password_sent_at.present? && reset_password_sent_at > Devise.reset_password_within.ago
  end

  def invalidate_old_tokens
    update!(reset_password_sent_at: nil, reset_password_token: nil)
  end
end
