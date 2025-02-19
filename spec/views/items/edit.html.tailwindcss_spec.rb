require 'rails_helper'

RSpec.describe "items/edit", type: :view do
  let(:item) {
    Item.create!(
      order: nil,
      product: nil,
      quantity: 1,
      price: 1
    )
  }

  before(:each) do
    assign(:item, item)
  end

  it "renders the edit item form" do
    render

    assert_select "form[action=?][method=?]", item_path(item), "post" do
      assert_select "input[name=?]", "item[order_id]"

      assert_select "input[name=?]", "item[product_id]"

      assert_select "input[name=?]", "item[quantity]"

      assert_select "input[name=?]", "item[price]"
    end
  end
end
