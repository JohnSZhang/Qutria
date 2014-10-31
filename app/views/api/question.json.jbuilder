json.id @question.id
json.title @question.title
json.body @question.body
json.user_id @question.user_id
json.vote_count @question.votes.sum(:vote_type)

json.user do
  json.id @question.user.id
  json.username @question.user.username
  json.email @question.user.email
end

json.tags @question.tags do |tag|
  json.id tag.id
  json.name tag.name
  json.description tag.description
end

json.comments @question.comments do |comment|
  json.id comment.id
  json.body comment.body
  json.user_id comment.user_id
  json.user comment.user
end

json.answers @question.answers do |answer|
  json.user answer.user
  json.vote_count answer.votes.sum(:vote_type)  
  json.comments answer.comments do |comment|
    json.id comment.id
    json.user comment.user
    json.body comment.body
  end
  json.id answer.id
  json.user_id answer.user_id
  json.body answer.body
end
