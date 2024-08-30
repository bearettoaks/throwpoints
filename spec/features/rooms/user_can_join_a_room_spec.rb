require "rails_helper"
require "rack_session_access/capybara"

RSpec.feature "User can join a room" do
  scenario "when not already in a room" do
    room = create(:room)

    visit join_room_path(room.code)
    fill_in "Display name", with: "Test Player"
    click_on "Join Room"

    expect(current_path).to eq(room_path(room.code))
    expect(page).to have_css(
      ".alert",
      text: "You have joined the room!"
    )
    expect(room.players.count).to eq(2)
    expect(room.players.last.name).to eq("Test Player")
    expect(room.players.last.votes).to be_empty
  end

  scenario "when already in a room is redirected back to the room and asked to leave first" do
    room = create(:room)
    player = create(:player, room: room)
    page.set_rack_session(current_room_code: room.code)
    page.set_rack_session(current_player_id: player.id)

    visit join_room_path(room.code)

    expect(current_path).to eq(room_path(room.code))
    expect(page).to have_css(
      ".alert",
      text: "You are already in a room. Leave the room to create a new one."
    )
  end
end
