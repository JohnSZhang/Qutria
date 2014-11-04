class Answer < ActiveRecord::Base
  validates :user, :question, :title, :body, presence: true
  belongs_to :user, inverse_of: :answers
  belongs_to :question, inverse_of: :answers
  has_one :questioner, through: :question, source: :user
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

end
