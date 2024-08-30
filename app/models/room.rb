class Room < ApplicationRecord
  before_create :generate_code

  has_one :host, class_name: "Player"
  has_many :players, dependent: :destroy

  attribute :revealed, :boolean, default: false

  def host
    players.find_by(id: host_id)
  end

  def generate_code
    self.code = loop do
      random_code = Array.new(10) { rand(0..9) }.join
      break random_code unless self.class.exists?(code: random_code)
    end
  end
end
