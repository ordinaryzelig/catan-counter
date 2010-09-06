class CitiesController < ApplicationController

  before_filter :load_player

  def downgrade_to_settlement
    @city = @player.cities.find(params[:id])
    @city.downgrade_to_settlement
    redirect_to game_url(@city.player.game)
  end

  private

  def load_player
    @player = Player.find(params[:player_id])
  end

end
