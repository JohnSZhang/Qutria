json.user @answer.user
json.vote_count @answer.vote_count
json.comments @answer.comments do |comment|
  json.id comment.id
  json.user comment.user
  json.body comment.body
end
json.id @answer.id
json.user_id @answer.user_id
json.body @answer.body
