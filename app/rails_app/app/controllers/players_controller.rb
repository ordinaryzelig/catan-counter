class PlayersController < ApplicationController
  
  def take_longest_road
    player = Player.find(params[:id])
    player.take_longest_road
    redirect_to player.game
  end
  
  protected
  
  def load_game
    @game = Game.find params[:game_id]
  end
  
end
