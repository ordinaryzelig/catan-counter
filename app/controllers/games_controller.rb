class GamesController < ApplicationController

  caches_page :new

  def show
    @game = Game.includes({:players => [:settlements, :cities, :knights, :soldiers]}).find(params[:id])
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
    @game = Game.new(params[:game])
    if @game.save
      @game.create_components
      if players_attributes
        @game.players_attributes = players_attributes
        @game.save!
      end
      redirect_to @game
    else
      render :new
    end
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes params[:game]
      redirect_to @game
    else
      render :edit
    end
  end

end
