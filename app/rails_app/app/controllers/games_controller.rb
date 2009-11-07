class GamesController < ApplicationController
  
  def show
    @game = Game.find(params[:id])
  end
  
  def new
    @game = Game.new
  end
  
  def create
    game_type = params[:game].delete(:game_type_attribute).constantize
    @game = game_type.new(params[:game])
    if @game.save
      flash[:success] = "game on!"
      redirect_to new_game_player_url(@game)
    else
      render 'new'
    end
  end
  
end
