class Room < ApplicationRecord

  validates :title, presence: true
  
  has_many :users
  has_many :room_tags ,dependent: :destroy
  has_many :tags ,through: :room_tags

  def save_tags(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?

    old_tags = current_tags - sent_tags
    fresh_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tag.deleteTag.find_by(name: old)
    end

    fresh_tags.each do | fresh|
      fresh_room_tags = Tag.find_or_create_by(name: fresh)
      self.tags <<  fresh_room_tags
    end
  end
end
