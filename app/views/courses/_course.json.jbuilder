json.extract! course, :id, :name, :admin, :credits, :created_at, :updated_at
json.url course_url(course, format: :json)
