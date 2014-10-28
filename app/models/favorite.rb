class Favorite < ActiveRecord::Base
    validates :user, :tag, presence: true
    validates :tag, uniqueness: { scope: :user, message: "Already Favorited!"}

    belongs_to :user, inverse_of: :favorites
    belongs_to :tag, inverse_of: :favorites

end
