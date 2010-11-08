class KnightsController < ApplicationController

  before_filter :load_player

  respond_to :js

  def create
    @knight = @player.knights.create!(:level => 1)
    respond_with do |format|
      format.html { redirect_to game_url(@player.game) }
    end
  end

  def destroy
    @knight = @player.knights.find(params[:id])
    @knight.destroy
    respond_with do |format|
      format.html { redirect_to game_url(@knight.player.game) }
    end
  end

  def promote
    @knight = @player.knights.find(params[:id])
    @knight.promote
    respond_with do |format|
      format.html { redirect_to game_url(@knight.player.game) }
    end
  end

  def toggle_activation
    @knight = @player.knights.find(params[:id])
    @knight.toggle_activation
    respond_with do |format|
      format.html { redirect_to game_url(@knight.player.game) }
    end
  end

  protected

  def load_player
    @player = Player.find(params[:player_id])
  end

end
