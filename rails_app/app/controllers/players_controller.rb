class PlayersController < ApplicationController
  
  def take_longest_road
    player = Player.find(params[:id])
    player.take_longest_road
    redirect_to player.game
  end
  
  def play_soldier
    @player = Player.find(params[:id])
    @player.play_soldier
    redirect_to @player.game
  end
  
  protected
  
end
