require 'rails_helper'

RSpec.describe "orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.create!(
        customer_name: "Customer Name",
        progress: 2,
        items: "Items",
        subtotal: "Subtotal",
        tax: "Tax",
        total: "Total"
      ),
      Order.create!(
        customer_name: "Customer Name",
        progress: 2,
        items: "Items",
        subtotal: "Subtotal",
        tax: "Tax",
        total: "Total"
      )
    ])
  end

  it "renders a list of orders" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Customer Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Items".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Subtotal".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Tax".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Total".to_s), count: 2
  end
end
