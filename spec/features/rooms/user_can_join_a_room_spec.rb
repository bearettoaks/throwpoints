require "rails_helper"

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

  scenario "when already in a room" do
    room = create(:room)
    user = create(:user, room: room)

    visit root_path
    fill_in "Room Code", with: room.code
    click_on "Join Room"

    expect(current_path).to eq(room_path(room.code))
    expect(page).to have_content("You are already in a room.")
  end
end
