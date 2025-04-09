FactoryBot.define do
  factory :item do
    order
    product
    quantity { 1 }
    price { 1 }
  end
end
