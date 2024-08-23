class VotesController < ApplicationController
  def create
    @room = Room.find_by!(code: params[:code])
    @player = current_player

    if @player.votes.create!(vote_params)
      broadcast_votes_update
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to room_path(@room.code) }
      end
    else
      flash[:error] = "Could not save your vote"
      redirect_to room_path(@room.code)
    end
  end

  private

  def broadcast_votes_update
    Turbo::StreamsChannel.broadcast_update_to @room, target: "players",
      partial: "rooms/players", locals: { room: @room, players: @room.players }
  end

  def vote_params
    params.require(:vote).permit(:value)
  end
end
