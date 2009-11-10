class GamesController < ApplicationController
  
  def show
    @game = Game.find(params[:id], :include => {:players => [:settlements, :cities, :knights]})
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
    if players_attributes
      game.players_attributes = players_attributes
      game.save!
    end
    redirect_to game
  end
  
  def update
    game = Game.find(params[:id])
    game.update_attributes! params[:game]
    redirect_to game
  end
  
end
