class PlayersController < ApplicationController

  before_filter :load_player

  respond_to :js

  def take_longest_road
    @former_player_with_longest_road = @player.game.players.with_longest_road
    @player.take_longest_road
    respond_with do |format|
      format.html { redirect_to @player.game }
    end
  end

  def play_soldier
    @player.play_soldier
    @former_player_with_largest_army = @player.just_acquired_largest_army_from
    respond_with do |format|
      format.html { redirect_to @player.game }
    end
  end

  def build_metropolis
    game = @player.game
    @development_area = params[:development_area]
    metropolis = game.metropolises.development_area(@development_area)
    @former_player_with_metropolis = metropolis.player
    @player.build_metropolis(@development_area)
    respond_with do |format|
      format.html { redirect_to @player.game }
    end
  end

  def take_boot
    @player.take_boot
    redirect_to @player.game
  end

  def take_merchant
    @player.take_merchant
    redirect_to @player.game
  end

  def take_progress_card_victory_point
    @player.take_progress_card_victory_point
    redirect_to @player.game
  end

  protected

  def load_player
    @player = Player.find(params[:id])
  end

end
