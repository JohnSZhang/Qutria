json.pages @tags.total_pages if defined? @tags.total_pages
json.tags @tags do |tag|
  json.id tag.id
  json.name tag.name
  json.description truncate(tag.description, length: 100)
  json.count tag.questions.count
end
