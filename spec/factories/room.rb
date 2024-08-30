FactoryBot.define do
  factory :room do
    code { "#{Array.new(10) { rand(0..9) }.join}" }
    host { association :player }
    revealed { false }
  end
end
