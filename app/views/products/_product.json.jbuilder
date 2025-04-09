json.extract! product, :id, :name, :description, :price, :active, :category, :created_at, :updated_at
json.url product_url(product, format: :json)
