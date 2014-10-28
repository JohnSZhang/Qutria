class Vote < ActiveRecord::Base
  validates :user,
    presence: true,
    uniqueness: { scope: :votable, message: "You already Voted!" }
  validates :votable, presence: true


  belongs_to :user
  belongs_to :votable, polymorphic: true

end
