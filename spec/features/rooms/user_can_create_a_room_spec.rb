require "rails_helper"

RSpec.feature "User can create a room" do
  scenario "when not already in a room" do
    visit root_path
    click_on "Create a Room"
    expect(current_path).to eq(new_room_path)
    fill_in "Display name", with: "Test Host"
    click_on "Create Room"

    room = Room.last
    player = room.players.last
    expect(player.name).to eq("Test Host")
    expect(room.players.count).to eq(1)
    expect(player.votes).to be_empty
    expect(current_path).to eq(room_path(room.code))
    expect(page).to have_css(
      ".alert",
      text: "Welcome to your room! Invite others to join using the link below."
    )
    expect(page).to have_css(".room-code", text: room.code)
    expect(page).to have_link("Join Room", href: join_room_path(room.code))
    [0, 1, 2, 3, 5, 8, 13, 21, 40, 100].each do |value|
      expect(page).to have_css(".vote-button", text: value)
    end
    expect(page).to have_content("Test User", count: 1)
    expect(page).to have_css(".reveal-button", text: "Reveal Votes")
    expect(page).to have_css(".reset-button", text: "Reset Votes")
  end
end
