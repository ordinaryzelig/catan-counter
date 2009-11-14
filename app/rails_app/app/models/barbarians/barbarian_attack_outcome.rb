class BarbarianAttackOutcome
  
  attr_reader :outcome
  attr_reader :players_with_strongest_army
  
  def initialize(outcome, barbarians)
    @outcome = outcome
    @barbarians = barbarians
    @game = barbarians.game
    case @outcome
    when :barbarians_win
      @game.players.with_weakest_army.each do |player|
        player.cities.first.destroy
      end
    when :settlers_successfully_defend
      @players_with_strongest_army = @game.players.with_strongest_army
      if defender_of_catan
        defender_of_catan.declare_defender_of_catan
      end
    end
    @game.knights.activated.each(&:deactivate)
  end
  
  def barbarians_win?
    @outcome == :barbarians_win
  end
  
  def settlers_successfully_defend?
    @outcome == :settlers_successfully_defend
  end
  
  def defender_of_catan
    @players_with_strongest_army.size == 1 ? @players_with_strongest_army.first : nil
  end
  
end
