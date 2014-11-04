module SeedHelper
  def self.get_questions(tag_name)
    filter = '!)(pBESiU73kvY1tjzDf8IZ1KqJRi9QX2tloPfPCH*_gco4_gYSskE'
    options = { order:'desc',
      sort: 'activity', filter: filter, pagesize: 6 }
    questions = RubyStackoverflow.questions(options.merge({ tagged: tag_name })).data
  end

  def self.save_question(question)
    owner = self.get_user(question)
    new_question = Question.new(
        user: owner,
        title: question.title,
        body: question.body,
        meta_vote_count: question.score)
    new_question.save!
  end

  def self.get_answers(questions)
    questions.each do |question|
      answers = RubyStackoverflow::Client::Answer.parse_data(question.answers)
    end
  end

  def self.get_users(objs)
    # Not Using Rubystackoverflow User Because Question User Are Shallow
    objs.each do |obj|
      self.get_user(obj)
    end
  end

  def self.get_user(obj)
    username = obj.owner[:display_name].html_safe
    user = self.user_create_or_find username
    user.filepicker_url ||= obj.owner[:profile_image]
    user.password="123456"
    user.email= "#{ username.gsub(/\s+/, '') }@example.com"
    user.save!
    user
  end

  def self.get_comments(objs)
    objs.each do |obj|
      comments = RubyStackoverflow::Client::Comment.parse_data(obj.comments)
    end
  end

  def self.user_create_or_find(username)
    new_user = User.find_by_username(username)
    new_user ? new_user : User.new( username: username )
  end

end
