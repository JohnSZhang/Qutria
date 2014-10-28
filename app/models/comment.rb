class Comment < ActiveRecord::Base
  validates :user, :body, :commentable_id, :commentable_id, presence: true

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :comment, as: :commentable

end
