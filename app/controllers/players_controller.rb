class PlayersController < ApplicationController

  respond_to :js

  def take_longest_road
    player = Player.find(params[:id])
    player.take_longest_road
    redirect_to player.game
  end

  def play_soldier
    @player = Player.find(params[:id])
    @player.play_soldier
    @former_player_with_largest_army = @player.just_acquired_largest_army_from
    respond_with do |format|
      format.html { redirect_to @player.game }
    end
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

end
