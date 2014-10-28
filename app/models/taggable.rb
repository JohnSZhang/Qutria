class Taggable < ActiveRecord::Base
  validates :taggings_id, :tagging_type, :tag_id, presence: true

  belongs_to :tag
  belongs_to :tagging, polymorphic: true
end
