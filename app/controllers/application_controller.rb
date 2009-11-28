class ApplicationController < ActionController::Base
  
  helper :all
  
  def rescue_in_public(ex)
    case ex
    when Soldier::NoMore
      flash[:error] = "there are no more soldiers in the deck"
      redirect_to @player.game
    end
  end
  
end
