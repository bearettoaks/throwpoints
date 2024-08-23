class PlayersController < ApplicationController
  def create
    @room = Room.find_by!(code: params[:code])
    @player = @room.players.new(player_params)

    if @player.save
      session[:current_player] = @player
      redirect_to room_path(@room.code)
    else
      flash[:error] = "There was an error joining the room"
      render :join
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :room_id)
  end
end
