json.array!(@itemtags) do |itemtag|
  json.extract! itemtag, :id, :name
  json.url itemtag_url(itemtag, format: :json)
end
