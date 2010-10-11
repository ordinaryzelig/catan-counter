class CitiesController < ApplicationController

  before_filter :load_player

  respond_to :js

  def downgrade_to_settlement
    @city = @player.cities.without_metropolises.first
    @city.downgrade_to_settlement
    respond_with do |format|
      format.html { redirect_to game_url(@city.player.game) }
    end
  end

  private

  def load_player
    @player = Player.find(params[:player_id])
  end

end
