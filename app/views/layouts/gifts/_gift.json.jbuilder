json.extract! gift, :id, :name, :price, :optional, :created_at, :updated_at
json.url gift_url(gift, format: :json)
