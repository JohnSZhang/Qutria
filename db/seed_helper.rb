module SeedHelper
  def self.get_questions(tag_name, sort)
    filter = '!FRQ4VUIaa880PeTBSXJP))vWQSulQE8_DD1CX(FKVYQ0*QtU9s4MYbw1*tf.JWTt(tK2gthy'
    options = { order:'desc',
      sort: sort, filter: filter, pagesize: 100 }
    questions = RubyStackoverflow.questions(options.merge({ tagged: tag_name })).data
  end

  def question_exit? (title)
    Question.find_by_title(title)
  end

  def self.create_question(question)
    owner = self.get_user(question)
    new_question = Question.new(
        user: owner,
        title: question.title,
        body: question.body,
        meta_vote_count: question.score,
        meta_create_date: question.creation_date,
        view_count: question.view_count)
    new_question.save
    self.parse_tags(new_question, question)
    new_question
  end

  def self.create_comments(stack_obj, rails_obj)
    unless stack_obj.comments.nil?
      comments = RubyStackoverflow::Client::Comment.parse_data(stack_obj.comments)
      comments.each do |comment|
        owner = self.get_user(comment)
        new_comment = Comment.new(
          user: owner,
          body: comment.body,
          meta_create_date: comment.creation_date,
          commentable: rails_obj
          )
        new_comment.save
      end
    end
  end

  def self.create_answer(answer, rails_q)
    owner = self.get_user(answer)
    new_answer = Answer.new(
        user: owner,
        title: answer.title,
        body: answer.body,
        question: rails_q,
        meta_vote_count: answer.score,
        meta_create_date: answer.creation_date,
        is_best: answer.is_accepted
        )
    new_answer.save
    new_answer
  end

  def self.parse_answers(question)
    answers = RubyStackoverflow::Client::Answer.parse_data(question.answers)
  end

  def self.get_user(obj)
    # Not Using Rubystackoverflow User Because Question User Are Shallow
    username = obj.owner[:display_name] ? obj.owner[:display_name].html_safe : 'unknown'
    user = self.user_create_or_find username
    user.filepicker_url ||= obj.owner[:profile_image]
    user.password="123456"
    user.email= "#{ username.gsub(/\s+/, '') }@example.com"
    user.save!
    user
  end

  def self.user_create_or_find(username)
    new_user = User.find_by_username(username)
    new_user ? new_user : User.new( username: username )
  end

  def self.parse_tags(rails_q, question)
    tags = question.tags #array of tag name strings
    tags.each do |tag|
      rails_tag = Taggable.create_or_find(tag)
      rails_tag.save
      Taggable.create!( tag: rails_tag, taggings: rails_q)
    end
  end
end
