class Comment < ActiveRecord::Base
  validates :user, :body, :commentable_id, :commentable_type, presence: true

  belongs_to :commentable, polymorphic: true
  belongs_to :user, inverse_of: :comments
  has_many :comment, as: :commentable, dependent: :destroy
  has_one :notification, as: :new_object, dependent: :destroy

  after_save :create_notification

  private
    def create_notification
      Notification.create!(
        user: self.commentable.user,
        new_object: self,
        notified_on: self.commentable
      )
    end

end
