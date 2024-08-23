class VotesController < ApplicationController
  def create
    @room = Room.find_by!(code: params[:code])
    @player = current_player

    if @player.votes.create!(vote_params)
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

  def vote_params
    params.require(:vote).permit(:value)
  end
end
