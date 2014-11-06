class Notification < ActiveRecord::Base
  paginates_per 5

  validates :new_object, :notified_on, :user, presence: true

  belongs_to :user, inverse_of: :notifications
  belongs_to :new_object, polymorphic: true
  belongs_to :notified_on, polymorphic: true

  def to_read
    self.read = true
    self.save
  end

end
