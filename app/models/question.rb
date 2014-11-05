class Question < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:title, :body]
  paginates_per 10

  validates :user, :title, :body, presence: true
  validates :title, uniqueness: true

  belongs_to :user, inverse_of: :questions
  has_many :answers, inverse_of: :question
  has_many :taggables, as: :taggings
  has_many :tags, through: :taggables, source: :tag
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

  def best_answer
    @best_answer = self.answers.where(is_best: true)
    @best_answer.count == 0 ? nil : @best_answer.first
  end

  def best_answer=(answer)
    return nil unless self.answers.include?(answer) &&
      self.answers.where(is_best: true).count == 0
    answer.is_best = true
    answer.save
  end

  def best_answer?
    self.answers.where(is_best: true).count > 0
  end
end
