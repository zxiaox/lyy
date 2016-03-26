json.array!(@welcomes) do |welcome|
  json.extract! welcome, :id, :name, :logo, :decription, :link, :org, :view, :viewhehe, :love
  json.url welcome_url(welcome, format: :json)
end
