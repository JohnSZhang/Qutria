json.pages @tags.total_pages
json.tags @tags do |tag|
  json.id tag.id
  json.name tag.name
  json.description tag.description
  json.count tag.questions.count
end
