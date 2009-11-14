class BarbariansController < ApplicationController
  
  before_filter :load_game
  
  def attack
    barbarians = @game.barbarians
    outcome = barbarians.attack
    flash[:notice] = []
    flash[:notice] << 'barbarians attacked'
    flash[:notice] << "#{outcome}: #{outcome.strength_of_victorious_party} to #{outcome.strength_of_defeated_party}"
    if outcome.barbarians_are_victorious?
      flash[:notice] << "#{outcome.players_with_weakest_army.map(&:name).to_sentence} lost a city"
    else
      if defender_of_catan = outcome.defender_of_catan
        flash[:notice] << "#{defender_of_catan.name} is the defender of catan"
      else
        flash[:notice] << "#{outcome.players_with_strongest_army.map(&:name).to_sentence} best defended catan"
      end
    end
    redirect_to @game
  end
  
  protected
  
  def load_game
    @game = Game.find(params[:game_id])
  end
  
end
