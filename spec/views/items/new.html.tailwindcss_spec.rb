require 'rails_helper'

RSpec.describe "items/new", type: :view do
  before(:each) do
    assign(:item, Item.new(
      order: nil,
      product: nil,
      quantity: 1,
      price: 1
    ))
  end

  it "renders new item form" do
    render

    assert_select "form[action=?][method=?]", items_path, "post" do
      assert_select "input[name=?]", "item[order_id]"

      assert_select "input[name=?]", "item[product_id]"

      assert_select "input[name=?]", "item[quantity]"

      assert_select "input[name=?]", "item[price]"
    end
  end
end
