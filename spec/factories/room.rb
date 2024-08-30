FactoryBot.define do
  factory :room do
    code { "#{Array.new(10) { rand(0..9) }.join}" }
    revealed { false }

    after(:create) do |room, evaluator|
      host = create(:player, room: room)
      room.update(host: host)
    end
  end
end
