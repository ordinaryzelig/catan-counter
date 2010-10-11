class SettlementsController < ApplicationController

  before_filter :load_player

  respond_to :js

  def create
    @player.settlements.create!
    redirect_to game_url(@player.game)
  end

  def upgrade_to_city
    @settlement = @player.settlements.first
    @settlement.upgrade_to_city
    respond_with do |format|
      format.html { redirect_to(@player.game) }
    end
  end

  def destroy
    settlement = @player.settlements.first
    settlement.destroy
    redirect_to game_url(settlement.player.game)
  end

  protected

  def load_player
    @player = Player.find(params[:player_id])
  end

end
