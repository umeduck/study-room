class Message < ApplicationRecord

  validates :content, presence: true, unless: :was_attached?

  belongs_to :room
  belongs_to :user

end
