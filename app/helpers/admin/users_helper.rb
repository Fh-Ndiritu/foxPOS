module Admin::UsersHelper
  def shift_period(user)
    return unless user.shift_start.present? && user.shift_end.present?

    "#{user.shift_start.strftime('%I:%M %p')} to #{user.shift_end.strftime('%I:%M %p')}"
  end

  def personal_details(user)
    {
      full_name: user.full_name,
      email: user.email,
      phone_number: user.phone,
      date_of_birth: user.birth_date&.strftime('%B %d, %Y'),
    }
  end

  # TODO: currency needs to move to locale
  def job_details(user)
    {
      role: user.role.titleize,
      shift: shift_period(user),
      salary: number_to_currency(user.salary, unit: 'Kes'),
      orders_served: user.orders.count
    }
  end
end
