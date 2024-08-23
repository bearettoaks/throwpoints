class RoomsController < ApplicationController
  def index
    flash[:notice] = "Welcome to the Rooms!"
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.create!
    @ploayer = @room.players.create!(room_params)

    redirect_to @room
  end

  def show
    @room = Room.find(params[:id])
    @players = @room.players.includes(:votes)
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
