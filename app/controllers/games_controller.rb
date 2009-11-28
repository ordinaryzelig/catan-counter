class GamesController < ApplicationController
  
  def show
    @game = Game.find(params[:id], :include => [:largest_army, :longest_road, {:players => [:settlements, :cities, :knights, :soldiers]}])
    @winners = @game.players.with_enough_victory_points_to_win
  end
  
  def new
    @game = Game.new
  end
  
  def edit
    @game = Game.find(params[:id])
  end
  
  def create
    # get players_attributes because game needs to be saved before adding players.
    players_attributes = params[:game].delete(:players_attributes)
    game = Game.new(params[:game])
    game.save!
    game.create_components
    if players_attributes
      game.players_attributes = players_attributes
      game.save!
    end
    if params[:add_expansions] == '1'
      redirect_to game_expansions_url(game)
    else
      redirect_to game
    end
  end
  
  def update
    game = Game.find(params[:id])
    game.update_attributes! params[:game]
    redirect_to game
  end
  
end
