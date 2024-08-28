class PlayersController < ApplicationController
  def create
    @room = Room.find_by!(code: params[:code])
    @player = @room.players.new(player_params)

    if @player.save
      flash[:notice] = "You have joined the room!"
      session[:current_player_id] = @player.id
      broadcast_players_update
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to room_path(@room.code) }
      end
    else
      flash[:error] = "There was an error joining the room"
      render :join
    end
  end

  def destroy
    @room = Room.find_by!(code: params[:code])
    @player = @room.players.find(params[:id])

    if @player.destroy
      session[:current_player_id] = nil
      broadcast_players_update
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path }
      end
    else
      flash[:error] = "There was an error leaving the room"
      render :join
    end
  end

  private

  def broadcast_players_update
    Turbo::StreamsChannel.broadcast_update_to @room, target: "players",
      partial: "rooms/players", locals: { room: @room,  players: @room.players }
  end

  def player_params
    params.require(:player).permit(:name, :room_id)
  end
end
