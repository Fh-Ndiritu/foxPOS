json.extract! order, :id, :customer_name, :progress, :items, :subtotal, :tax, :total, :created_at, :updated_at
json.url order_url(order, format: :json)
