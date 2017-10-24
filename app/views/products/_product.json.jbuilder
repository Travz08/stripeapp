json.extract! product, :id, :name, :price, :image_data, :user_id, :created_at, :updated_at
json.url product_url(product, format: :json)
