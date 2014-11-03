class Tag < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:name, :description]
  pg_search_scope :search_by_name, :against => :name

  validates :name, presence: true, uniqueness: true, length: { minimum: 2 }

  has_many :taggables
  has_many :questions,
    through: :taggables,
    source: :taggings,
    source_type: "Question"
  has_many :favorites, inverse_of: :tag
  has_many :chats, inverse_of: :tag

end
