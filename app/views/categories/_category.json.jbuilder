json.extract! category, :id, :name, :image, :created_at, :updated_at
json.url category_url(category, format: :json)
json.image url_for(category.image)
