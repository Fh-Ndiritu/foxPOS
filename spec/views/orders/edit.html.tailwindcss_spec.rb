require 'rails_helper'

RSpec.describe "orders/edit", type: :view do
  let(:order) {
    Order.create!(
      customer_name: "MyString",
      progress: 1,
      items: "MyString",
      subtotal: "MyString",
      tax: "MyString",
      total: "MyString"
    )
  }

  before(:each) do
    assign(:order, order)
  end

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(order), "post" do
      assert_select "input[name=?]", "order[customer_name]"

      assert_select "input[name=?]", "order[progress]"

      assert_select "input[name=?]", "order[items]"

      assert_select "input[name=?]", "order[subtotal]"

      assert_select "input[name=?]", "order[tax]"

      assert_select "input[name=?]", "order[total]"
    end
  end
end
