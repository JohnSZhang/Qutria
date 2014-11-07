json.array! @results do |result|
  json.id result.id
  json.searchable_id result.searchable_id
  json.searchable_type result.searchable_type
  json.content truncate(result.content, length: 25)
  json.link "#/#{result.searchable_type.tableize}/#{result.searchable_id}"
end
