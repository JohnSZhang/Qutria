class Taggable < ActiveRecord::Base
  validates :taggings_id, :taggings_type, :tag_id, presence: true

  belongs_to :tag
  belongs_to :taggings, polymorphic: true
end
