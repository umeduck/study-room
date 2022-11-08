class Tag < ApplicationRecord
  has_many :room_tags,dependent: :destroy
  has_many :rooms,through: :room_tags

  validates :name, uniqueness: { case_sensitive: true }, presence: true
end
