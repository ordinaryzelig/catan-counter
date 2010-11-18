class BarbarianAttackOutcome

  OUTCOMES = {1 => :barbarians_are_victorious, -1 => :catan_is_safe, 0 => :catan_is_safe}

  attr_reader :players_with_strongest_army
  attr_reader :players_with_weakest_army
  attr_reader :strength_of_victorious_party
  attr_reader :strength_of_defeated_party

  extend ActiveSupport::Memoizable

  def initialize(barbarians)
    @barbarians = barbarians
    determine_outcome
  end

  def barbarians_are_victorious?
    @outcome == :barbarians_are_victorious
  end

  def catan_is_safe?
    @outcome == :catan_is_safe
  end

  def defender_of_catan
    players_with_strongest_army.size == 1 ? players_with_strongest_army.first : nil
  end

  def to_s
    @outcome.to_s.humanize + '!'
  end

  def message
    message = []
    message << 'barbarians attacked'
    message << "#{to_s} (barbarians: #{strength_of_victorious_party}, knights: #{strength_of_defeated_party})"
    if barbarians_are_victorious?
      message << "#{players_with_weakest_army.map(&:name).to_sentence} lost a city"
    else
      if defender_of_catan = defender_of_catan
        message << "#{defender_of_catan.name} is the defender of catan"
      else
        defenders = players_with_strongest_army(&:map)
        defenders_string = if defenders.empty?
          'nobody'
        else
          "#{defenders.size} players (#{defenders.map(&:name).to_sentence}) best"
        end
        message << "#{defenders_string} defended catan"
      end
    end
    message.join("\n")
  end
  memoize :message

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
    when :catan_is_safe
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
