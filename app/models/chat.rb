class Chat < ActiveRecord::Base
  validates :message, :user, :tag, presence: true
  belongs_to :user, inverse_of: :chats
  belongs_to :tag, inverse_of: :chats
end
