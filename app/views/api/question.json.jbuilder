json.id @question.id
json.title @question.title
json.body @question.body
json.user_id @question.user_id
json.vote_count @question.vote_count
json.answered @question.best_answer?
json.best_answer_id @question.best_answer ? @question.best_answer.id : 0
if current_user && current_user.voted_questions.include?(@question)
  json.vote_type current_user.votes.where(votable_type: "Question",
      votable_id: @question).first.vote_type
end

json.user do
  json.id @question.user.id
  json.filepicker_url @question.user.filepicker_url
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
  json.vote_count answer.vote_count
  if current_user && current_user.voted_answers.include?(answer)
    json.vote_type current_user.votes.where(votable_type: "Answer",
        votable_id: answer.id).first.vote_type
  end
  json.comments answer.comments do |comment|
    json.id comment.id
    json.user comment.user
    json.body comment.body
  end
  json.id answer.id
  json.user_id answer.user_id
  json.body answer.body
end
