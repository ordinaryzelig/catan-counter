class PlayersController < ApplicationController
  
  def take_longest_road
    player = Player.find(params[:id])
    player.take_longest_road
    redirect_to player.game
  end
  
  def play_soldier
    player = Player.find(params[:id])
    player.play_soldier
    redirect_to player.game
  end
  
  def build_metropolis
    player = Player.find(params[:id])
    player.build_metropolis(params[:development_area])
    redirect_to player.game
  end
  
  def take_boot
    player = Player.find(params[:id])
    player.take_boot
    redirect_to player.game
  end
  
  def take_merchant
    player = Player.find(params[:id])
    player.take_merchant
    redirect_to player.game
  end
  
  def take_progress_card_victory_point
    player = Player.find(params[:id])
    player.take_progress_card_victory_point
    redirect_to player.game
  end
  
  protected
  
end
