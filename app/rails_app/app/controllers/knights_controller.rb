class KnightsController < ApplicationController
  
  before_filter :load_player
  
  def create
    @player.knights.create!(params[:knight])
    redirect_to game_url(@player.game)
  end
  
  protected
  
  def load_player
    @player = Player.find(params[:player_id])
  end
  
end
