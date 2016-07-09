json.array!(@receipts) do |item|
  json.extract! item, :id, :title, :description
  json.url item_url(item, format: :json)
end
