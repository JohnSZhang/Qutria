class Vote < ActiveRecord::Base
  validates :user,
    presence: true,
    uniqueness: { scope: [:votable_id, :votable_type], message: "You already Voted!" }
  validates :votable, presence: true
  validates :vote_type, presence: true, inclusion: { in: [-1, 0, 1] }

  belongs_to :user, inverse_of: :votes
  belongs_to :votable, polymorphic: true

end
