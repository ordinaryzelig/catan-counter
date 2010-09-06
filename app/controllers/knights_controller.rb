class KnightsController < ApplicationController

  before_filter :load_player

  def create
    @player.knights.create!(:level => 1)
    redirect_to game_url(@player.game)
  end

  def destroy
    @knight = @player.knights.find(params[:id])
    @knight.destroy
    redirect_to game_url(@knight.player.game)
  end

  def promote
    @knight = @player.knights.find(params[:id])
    @knight.promote
    redirect_to game_url(@knight.player.game)
  end

  def toggle_activation
    @knight = @player.knights.find(params[:id])
    @knight.toggle_activation
    redirect_to game_url(@knight.player.game)
  end

  protected

  def load_player
    @player = Player.find(params[:player_id])
  end

end
