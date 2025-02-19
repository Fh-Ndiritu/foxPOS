module OrdersHelper
  def product_quantity(product, order)
    order.items.find_by(product:)&.quantity.to_i
  end

def progress_form(order)
    next_progress = next_progress_state(order.progress)
    return if next_progress.nil?

    form_with(model: order, data: { turbo: false }, method: :patch) do
      content_tag :button, progress_button_text(next_progress),
                  type: "submit",
                  name: "order[progress]",
                  value: next_progress,
                  class: "btn cursor-pointer flex items-center font-semibold rounded-lg text-center duration-200 bg-bg-tertiary px-4 py-2 hover:bg-bg-secondary text-gray-900 hover:text-white max-w-[15rem]"
    end
  end

  private

  def next_progress_state(current_progress)
    case current_progress
    when "pending" then :kitchen
    when "kitchen" then :ready
    when "ready" then :served
    when "served" then :payment
    when "payment" then :complete
    else nil
    end
  end

  def progress_button_text(next_progress)
    {
      kitchen: "Send to Kitchen",
      ready: "Mark as Ready",
      served: "Mark as Served",
      payment: "Mark as Paid",
      complete: "Mark as Complete"
    }[next_progress]
  end

  def progress_button_class(next_progress)
    {
      kitchen: "btn btn-primary",
      ready: "btn btn-warning",
      served: "btn btn-info",
      payment: "btn btn-secondary",
      complete: "btn btn-success",
    }[next_progress]
  end
end
