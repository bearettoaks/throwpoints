FactoryBot.define do
  factory :vote do
    player { create(:player) }
    value { [1, 2, 3, 5, 8, 13].sample }
  end
end
