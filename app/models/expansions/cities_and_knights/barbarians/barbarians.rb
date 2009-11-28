class Barbarians
  
  attr_reader :game
  
  def initialize(game)
    @game = game
  end
  
  def attack
    outcome = BarbarianAttackOutcome.new(self)
    @game.knights.activated.each(&:deactivate)
    outcome
  end
  
  def strength
    @game.cities.size
  end
  
  def strength_defended_against
    @game.knights.activated.map(&:strength).sum
  end
  
end
