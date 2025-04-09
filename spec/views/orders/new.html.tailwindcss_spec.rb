require 'rails_helper'

RSpec.describe "orders/new", type: :view do
  before(:each) do
    assign(:order, Order.new(
      customer_name: "MyString",
      progress: 1,
      items: "MyString",
      subtotal: "MyString",
      tax: "MyString",
      total: "MyString"
    ))
  end

  it "renders new order form" do
    render

    assert_select "form[action=?][method=?]", orders_path, "post" do
      assert_select "input[name=?]", "order[customer_name]"

      assert_select "input[name=?]", "order[progress]"

      assert_select "input[name=?]", "order[items]"

      assert_select "input[name=?]", "order[subtotal]"

      assert_select "input[name=?]", "order[tax]"

      assert_select "input[name=?]", "order[total]"
    end
  end
end
