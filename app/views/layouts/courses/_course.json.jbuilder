json.extract! course, :id, :name, :price, :max_size, :created_at, :updated_at
json.url course_url(course, format: :json)
