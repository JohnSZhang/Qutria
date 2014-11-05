json.id question.id
json.title question.title
json.exerpt truncate(Nokogiri::HTML(question.body).xpath("//text()").to_s, length: 200)
json.votes question.meta_vote_count ? question.meta_vote_count : 0
json.user_vote question.votes.count
json.answers question.answers.count
json.answered question.best_answer?
json.create question.meta_create_date ? time_ago_in_words(question.meta_create_date) : time_ago_in_words(question.created_at)
json.user question.user.username
json.user_id question.user.id
json.user_img question.user.filepicker_url
json.tags question.tags do |tag|
  json.id tag.id
  json.name tag.name
end
