class CitiesController < ApplicationController
  
  def downgrade_to_settlement
    @city = City.find(params[:id])
    @city.downgrade_to_settlement
    redirect_to game_url(@city.player.game)
  end
  
end
