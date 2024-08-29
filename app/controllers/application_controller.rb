class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def current_player
     @current_player ||= Player.find_by(id: session[:current_player_id])
  end
  helper_method :current_player

  def current_room
    @current_room ||= Room.find_by(code: session[:current_room_code])
  end
  helper_method :current_room
end
