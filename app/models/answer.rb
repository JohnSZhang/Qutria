class Answer < ActiveRecord::Base
  validates :user, :question, :title, :body, presence: true
  belongs_to :user, inverse_of: :answers
  belongs_to :question, inverse_of: :answers
  has_one :questioner, through: :question, source: :user
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  has_many :notifications, as: :new_object
  has_one :notified, as: :notified_on

  after_save :create_notification

  private
    def create_notification
      Notification.create!(
        user: self.user,
        new_object: self,
        notified_on: self.question
      )
    end
end
