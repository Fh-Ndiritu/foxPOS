FactoryBot.define do
  factory :order do
    customer_name { "MyString" }
    progress { 1 }
    items { "MyString" }
    subtotal { "MyString" }
    tax { "MyString" }
    total { "MyString" }
  end
end
