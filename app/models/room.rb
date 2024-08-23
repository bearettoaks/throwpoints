class Room < ApplicationRecord
  before_create :generate_code

  has_many :players

  def generate_code
    self.code = loop do
      random_code = Array.new(10) { rand(0..9) }.join
      break random_code unless self.class.exists?(code: random_code)
    end
  end
end
