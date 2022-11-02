class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
   validates :name
   validates :school_year_id, numericality: { other_than: 1, message: "can't be blank" }
  end
  has_many :rooms
  has_many :messages
end
