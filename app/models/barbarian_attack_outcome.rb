class BarbarianAttackOutcome

  OUTCOMES = {1 => :barbarians_are_victorious, -1 => :catan_is_saved, 0 => :catan_is_saved}

  attr_reader :players_with_strongest_army
  attr_reader :players_with_weakest_army
  attr_reader :strength_of_victorious_party
  attr_reader :strength_of_defeated_party

  def initialize(barbarians)
    @barbarians = barbarians
    determine_outcome
  end

  def barbarians_are_victorious?
    @outcome == :barbarians_are_victorious
  end

  def catan_is_saved?
    @outcome == :catan_is_saved
  end

  def defender_of_catan
    players_with_strongest_army.size == 1 ? players_with_strongest_army.first : nil
  end

  def to_s
    @outcome.to_s.humanize + '!'
  end

  private

  def determine_outcome
    @outcome = OUTCOMES[@barbarians.strength <=> @barbarians.strength_defended_against]
    game = @barbarians.game
    case @outcome
    when :barbarians_are_victorious
      @strength_of_victorious_party = @barbarians.strength
      @strength_of_defeated_party = @barbarians.strength_defended_against
      @players_with_weakest_army = game.players.with_weakest_army
      @players_with_weakest_army.each do |player|
        player.cities.first.downgrade_to_settlement
      end
    when :catan_is_saved
      @strength_of_victorious_party = @barbarians.strength_defended_against
      @strength_of_defeated_party = @barbarians.strength
      @players_with_strongest_army = game.players.with_strongest_army
      if defender_of_catan
        defender_of_catan.declare_defender_of_catan
      end
    end
    game.knights.activated.each(&:deactivate)
  end

end
