json.array!(@cars) do |car|
  json.extract! car, :id, :title
  json.url car_url(car, format: :json)
end
