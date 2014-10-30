json.id @tag.id
json.name @tag.name
json.description @tag.description
json.questions @tag.questions do |question|
  json.id question.id
  json.title question.title
  json.body question.body
  json.user do
    json.id question.user.id
    json.username question.user.username
  end
end
if @favorite && @favorite.persisted?
  json.favorite true
else
  json.favorite false
end
