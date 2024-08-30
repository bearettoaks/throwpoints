FactoryBot.define do
  factory :player do
    name { "Player" }
    room { create(:room) }
  end
end
