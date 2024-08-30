class RoomsController < ApplicationController
  def index
    if current_player && current_room
      flash[:notice] = "You are already in a room. Leave the room to create a new one."
      redirect_to room_path(current_room.code)
    end
  end

  def new
    @room = Room.new
  end

  def create
    if room_params[:name].blank?
      flash[:error] = "Display name can't be blank"
      return redirect_to new_room_path
    end

    @room = Room.new
    @player = @room.players.build(room_params)
    @room.host = @player

    if @room.save
      session[:current_player_id] = @player.id
      session[:current_room_code] = @room.code

      flash[:notice] = "Welcome to your room! Invite others to join using the link below."
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
    if current_player && current_room
      flash[:notice] = "You are already in a room. Leave the room to create a new one."
      redirect_to room_path(current_room.code)
    else
      @room = Room.find_by!(code: params[:code])
      @player = @room.players.new
    end
  end

  def reveal
    @room = Room.find_by!(code: params[:code])
    if @room.update(revealed: true)
      broadcast_reveal_update
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to room_path(@room.code) }
      end
    else
      flash[:error] = "There was an error revealing the votes"
      redirect_to room_path(@room.code)
    end
  end

  def reset_votes
    @room = Room.find_by!(code: params[:code])
    @room.players.each { |player| player.votes.destroy_all }
    @room.update(revealed: false)

    broadcast_votes_update
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to room_path(@room.code) }
    end
  end

  private

  def broadcast_reveal_update
    Turbo::StreamsChannel.broadcast_update_to @room, target: "players",
      partial: "rooms/players", locals: { room: @room, players: @room.players }
  end

  def broadcast_votes_update
    Turbo::StreamsChannel.broadcast_update_to @room, target: "votes",
      partial: "rooms/vote_buttons", locals: { room: @room }
    Turbo::StreamsChannel.broadcast_update_to @room, target: "players",
      partial: "rooms/players", locals: { room: @room, players: @room.players }
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
