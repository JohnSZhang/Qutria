class Answer < ActiveRecord::Base
  validates :user, :question, :title, :body, presence: true
  belongs_to :user, inverse_of: :answers
  belongs_to :question, inverse_of: :answers
  has_one :questioner, through: :question, source: :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_one :notification, as: :new_object, dependent: :destroy

  after_save :create_notification
  def vote_count
    if self.meta_vote_count
      self.votes.sum(:vote_type) + self.meta_vote_count
    else
      self.votes.sum(:vote_type)
    end
  end

  private
    def create_notification
      Notification.create!(
        user: self.question.user,
        new_object: self,
        notified_on: self.question
      )
    end
end
