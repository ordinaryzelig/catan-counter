class BarbariansController < ApplicationController

  before_filter :load_game

  respond_to :js

  def attack
    barbarians = @game.barbarians
    @outcome = barbarians.attack
    respond_with do |format|
      format.html { redirect_to @game }
    end
  end

  protected

  def load_game
    @game = Game.find(params[:game_id])
  end

end
