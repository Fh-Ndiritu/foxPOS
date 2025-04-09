json.extract! item, :id, :order_id, :product_id, :quantity, :price, :created_at, :updated_at
json.url item_url(item, format: :json)
