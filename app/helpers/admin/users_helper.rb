module Admin::UsersHelper
  def shift_period(user)
    return unless user.shift_start.present? && user.shift_end.present?

    "#{user.shift_start.strftime('%I:%M %p')} to #{user.shift_end.strftime('%I:%M %p')}"
  end
end
