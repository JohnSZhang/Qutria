json.user do
  json.id @user.id
  json.username @user.username
end

json.favorite_tags @user.favorite_tags do |tag|
  json.id tag.id
  json.name tag.name
  json.description tag.description
end

json.favorite_tag_questions @user.favorite_tag_questions do |question|
  json.id question.id
  json.title question.title
  json.body question.body
end
