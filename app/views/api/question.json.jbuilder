json.id @question.id
json.title @question.title
json.body @question.body
json.user_id @question.user_id

json.tags @question.tags do |tag|
  json.id tag.id
  json.name tag.name
end

json.comments @question.comments do |comment|
  json.id comment.id
  json.body comment.body
  json.user_id comment.user_id
  json.all comment
end

json.answers @question.answers do |answer|
  json.id answer.id
  json.user_id answer.user_id
  json.body answer.body
end
