json.user @answer.user
json.vote_count @answer.vote_count
json.comments @answer.comments do |comment|
  json.id comment.id
  json.user comment.user
  json.body comment.body
end
if current_user && current_user.voted_answers.include?(@answer)
  json.vote_type current_user.votes.where(votable_type: "Answer",
      votable_id: @answer.id).first.vote_type
end
json.id @answer.id
json.user_id @answer.user_id
json.body @answer.body
