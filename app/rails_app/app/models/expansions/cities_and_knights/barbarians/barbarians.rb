class Barbarians
  
  OUTCOMES = {1 => :barbarians_win, -1 => :settlers_successfully_defend, 0 => :settlers_successfully_defend}
  
  attr_reader :game
  
  def initialize(game)
    @game = game
  end
  
  def attack
    outcome = BarbarianAttackOutcome.new(OUTCOMES[strength <=> defended_against], self)
    @game.knights.activated.each(&:deactivate)
    outcome
  end
  
  def strength
    @game.cities.size
  end
  
  def defended_against
    @game.knights.activated.map(&:strength).sum
  end
  
end
