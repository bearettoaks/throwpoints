class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    if room_params[:name].blank?
      flash[:error] = "Display name can't be blank"
      return redirect_to new_room_path
    end

    @room = Room.create!
    @host = @room.players.create!(room_params)
    @room.host_id = @host.id
    session[:current_player] = @host

    if @room.save
      redirect_to room_path(@room.code)
    else
      flash[:error] = "There was an error creating the room"
      render :index
    end
  end

  def show
    @room = Room.find_by!(code: params[:code])
    @players = @room.players.includes(:votes)
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Room # #{params[:code]} was not found."
    redirect_to root_path
  end

  def join
    @room = Room.find_by!(code: params[:code])
    @player = @room.players.new
  end

  def reveal
    @room = Room.find_by!(code: params[:code])
    if @room.update(revealed: true)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to room_path(@room.code) }
      end
    else
      flash[:error] = "There was an error revealing the votes"
      redirect_to room_path(@room.code)
    end
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
