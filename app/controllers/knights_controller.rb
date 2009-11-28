class KnightsController < ApplicationController
  
  before_filter :load_player, :except => [:promote, :toggle_activation, :destroy]
  
  def create
    @player.knights.create!(:level => 1)
    redirect_to game_url(@player.game)
  end
  
  def destroy
    @knight = Knight.find(params[:id])
    @knight.destroy
    redirect_to game_url(@knight.player.game)
  end
  
  def promote
    @knight = Knight.find(params[:id])
    @knight.promote
    redirect_to game_url(@knight.player.game)
  end
  
  def toggle_activation
    @knight = Knight.find(params[:id])
    @knight.toggle_activation
    redirect_to game_url(@knight.player.game)
  end
  
  protected
  
  def load_player
    @player = Player.find(params[:player_id])
  end
  
end
