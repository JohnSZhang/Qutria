class Comment < ActiveRecord::Base
  validates :user, :body, :commentable_id, :commentable_type, presence: true

  belongs_to :commentable, polymorphic: true
  belongs_to :user, inverse_of: :comments
  has_many :comment, as: :commentable
  has_many :notifications, as: :new_object

  after_save :create_notification

  private
    def create_notification
      Notification.create!(
        user: self.user,
        new_object: self,
        notified_on: self.commentable
      )
    end

end
