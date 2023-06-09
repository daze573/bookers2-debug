class Room < ApplicationRecord
  has_many :users, through: :user_rooms
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
end
