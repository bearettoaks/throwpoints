class Player < ApplicationRecord
  belongs_to :room
  has_many :votes, dependent: :destroy
  has_many :hosted_rooms, class_name: "Room", foreign_key: "host_id", dependent: :nullify
end
