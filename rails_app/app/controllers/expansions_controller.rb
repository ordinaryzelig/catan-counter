class ExpansionsController < ApplicationController
  
  before_filter :load_game
  
  def index
    
  end
  
  protected
  
  def load_game
    @game = Game.find(params[:game_id], :include => :expansions)
  end
  
end
