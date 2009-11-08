class SettlementsController < ApplicationController
  
  before_filter :load_player, :except => [:upgrade_to_city]
  
  def create
    @player.settlements.create!
    redirect_to game_url(@player.game)
  end
  
  def upgrade_to_city
    @settlement = Settlement.find(params[:id])
    @settlement.upgrade_to_city
    redirect_to game_url(@settlement.player.game)
  end
  
  protected
  
  def load_player
    @player = Player.find(params[:player_id])
  end
  
end
