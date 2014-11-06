class Comment < ActiveRecord::Base
  validates :user, :body, :commentable_id, :commentable_type, presence: true

  belongs_to :commentable, polymorphic: true
  belongs_to :user, inverse_of: :comments
  has_many :comment, as: :commentable

end
