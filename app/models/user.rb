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

  validates :full_name, presence: true
  validates_presence_of :email
  has_many :orders
  validates :avatar, content_type: [ "image/png", "image/heic", "image/jpeg", "image/webp", "image/heif" ], if: -> { avatar.attached? }
  validates :avatar, size: { less_than: 3.megabytes, message: "is too big" }, if: -> { avatar.attached? }


  default_scope { where(hidden: false).order(role: :asc) }

  def management?
    super_admin? || admin? || manager?
  end

   def manageable?(current_user)
    return true if current_user.super_admin?
    role_before_type_cast > current_user.role_before_type_cast
  end

  def manageable_users
    self.class.where(role: manageable_roles.keys).where.not(id: id)
  end

  def manageable_roles
    return self.class.roles if super_admin?

    self.class.roles.select { |name, value| value > role_before_type_cast }
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

  private

  def avatar_format
    return if !avatar.attached? || avatar.blob.content_type.start_with?("image/")

    errors.add(:avatar, "must be an image")
  end
end
