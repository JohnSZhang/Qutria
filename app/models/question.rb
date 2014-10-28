class Question < ActiveRecord::Base
  validates :user, :title, :body, presence: true
  validates :title, uniqueness: true

  belongs_to :user, inverse_of: :questions
  has_many :answers, inverse_of: :question
  has_many :taggables, as: :taggings
  has_many :tags, through: :taggables, source: :tag
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

end
