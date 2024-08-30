require "rails_helper"

RSpec.feature "User can vote" do
  scenario "when in a room" do
    room = create(:room)
    player = create(:player, room: room)

    visit room_path(room.code)

    [0, 1, 2, 3, 5, 8, 13, 21, 40, 100].each do |value|
      find(".vote-button", text: value).click
      expect(".player-#{player.id}-vote").to have_text(value)
    end

    expect(current_path).to eq(room_path(room.code))
    expect(page).to have_css(
      ".alert",
      text: "You have voted!"
    )
    expect(player.votes.count).to eq(1)
  end
end
