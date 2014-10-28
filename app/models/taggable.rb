class Taggable < ActiveRecord::Base
  validates :taggings_id, :taggings_type, :tag_id, presence: true

  belongs_to :tag
  belongs_to :taggings, polymorphic: true

  def self.CreateAndTag(name)
    tag = Tag.find_by_name(name)
    if tag
      tag
    else
      tag = Tag.create(
        name: name
      )
    end
  end


end
