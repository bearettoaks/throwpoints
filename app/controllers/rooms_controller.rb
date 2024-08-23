class RoomsController < ApplicationController
  def index
    flash[:notice] = "Welcome to the Rooms!"
  end
end
