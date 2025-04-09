module ApplicationHelper
  def active_class(controller, action)
    "active" if controller_name == controller && action_name == action
  end

   def flash_class_for(type)
    case type.to_sym
    when :notice
      "bg-green-500"
    when :alert
      "bg-yellow-500"
    when :error
      "bg-red-500"
    else
      "bg-blue-500"
    end
  end

  def flash_icon_for(type)
    case type.to_sym
    when :notice
      '<svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" /></svg>'.html_safe
    when :alert
      '<svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M12 4.5c.31-.19.68-.19.99 0a7.498 7.498 0 11-1.98 0z" /></svg>'.html_safe
    when :error
      '<svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 5.636a9 9 0 11-12.728 0M12 8v4m0 4h.01" /></svg>'.html_safe
    else
      '<svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" /></svg>'.html_safe
    end
  end
end
