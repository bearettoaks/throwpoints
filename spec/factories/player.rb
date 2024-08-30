FactoryBot.define do
  factory :player do
    name { "Player" }
    association :room
  end
end
