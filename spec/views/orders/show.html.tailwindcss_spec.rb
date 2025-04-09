require 'rails_helper'

RSpec.describe "orders/show", type: :view do
  before(:each) do
    assign(:order, Order.create!(
      customer_name: "Customer Name",
      progress: 2,
      items: "Items",
      subtotal: "Subtotal",
      tax: "Tax",
      total: "Total"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Customer Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Items/)
    expect(rendered).to match(/Subtotal/)
    expect(rendered).to match(/Tax/)
    expect(rendered).to match(/Total/)
  end
end
