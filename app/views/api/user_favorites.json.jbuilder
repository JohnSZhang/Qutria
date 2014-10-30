json.id @user.id
json.username @user.username
json.array! @user.favorite_tags do |tag|
  json.id tag.id
  json.name tag.name
end

json.array! @user.favorite_tag_questions do |question|
  json.id question.id
  json.title question.title
  json.body question.body
end
