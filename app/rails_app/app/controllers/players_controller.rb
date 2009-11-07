class PlayersController < ApplicationController
  
  before_filter :load_game
  
  def new
    @player = @game.players.build
  end
  
  def create
    @player = @game.players.build(params[:player])
    if @player.save
      flash[:success] = "#{@player.color} has entered catan"
      redirect_to game_url(@game)
    else
      render 'new'
    end
  end
  
  protected
  
  def load_game
    @game = Game.find params[:game_id]
  end
  
end
