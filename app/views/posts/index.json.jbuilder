json.array!(@posts) do |post|
  json.extract! post, :id, :title, :description, :type, :life_cycle
  json.url post_url(post, format: :json)
end
