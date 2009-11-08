class GamesController < ApplicationController
  
  def show
    @game = Game.find(params[:id])
  end
  
  def new
    @game = Game.new
  end
  
  def create
    # get game type for STI.
    game_type = params[:game].delete(:game_type_attribute).constantize
    # get players_attributes because game needs to be saved before adding players.
    players_attributes = params[:game].delete(:players_attributes)
    @game = game_type.new(params[:game])
    @game.save!
    @game.players_attributes = players_attributes
    @game.save!
    flash[:success] = "game on!"
    redirect_to game_url(@game)
  end
  
end
