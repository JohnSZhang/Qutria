json.pages @questions.total_pages
json.questions  @questions, partial: 'api/partial/question', as: :question
