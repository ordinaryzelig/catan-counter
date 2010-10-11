module CitiesAndKnights

  # TODO: all expansions share this code.
  # need to figure out how to DRY it up.
  def self.extended(object)
    case object
    when Game
      object.extend GameMethods
    when Player
      object.extend PlayerMethods
    else
      raise "don't know how to extend #{object.class} with expansion"
    end
  end

  module GameMethods

    def default_victory_points_to_win
      super + 3
    end

    # overwrite.
    def create_components
      create_metropolises
      create_defenders_of_catan
      create_merchant
      create_progress_card_victory_points
      super
    end

    def barbarians
      @barbarians ||= Barbarians.new(self)
    end

    private

    # do nothing.
    def create_largest_army
    end

    # do nothing.
    def create_soldiers
    end

    def expansion_added(expansion)
      update_attributes! :victory_points_to_win => default_victory_points_to_win
    end

    def create_defenders_of_catan
      DefenderOfCatan.limit_per_game.times { defenders_of_catan.create! }
    end

    def create_metropolises
      Metropolis::DEVELOPMENT_AREAS.each do |development_area|
        metropolises.create! :development_area => development_area
      end
    end

    def create_progress_card_victory_points
      ProgressCardVictoryPoint.limit_per_game.times { progress_card_victory_points.create! }
    end

  end

  module PlayerMethods

    def create_starter_buildings
      settlements.create!
      cities.create!
    end

    def victory_points
      super +
      defenders_of_catan.size +
      (metropolises.size * 2) +
      (merchant ? 1 : 0) +
      progress_card_victory_points.size
    end

    def take_merchant
      (self.merchant = game.merchant).save!
    end

    def take_progress_card_victory_point
      self.progress_card_victory_points << game.progress_card_victory_points.not_taken.first
    end

    def declare_defender_of_catan
      defenders_of_catan << game.defenders_of_catan.not_taken.first
    end

    # can build if has cities without metropolises and doesn't already have that metropolis.
    def can_build_metropolis?(development_area = nil)
      return false unless cities.without_metropolises.any?
      if development_area
        !has_metropolis?(development_area)
      else
        true
      end
    end

    def has_metropolis?(development_area)
      metropolises.map(&:development_area).include?(development_area)
    end

    def build_metropolis(development_area)
      city = cities.without_metropolises.first
      metropolis = game.metropolises.development_area(development_area)
      city.metropolis = metropolis
    end

    def immune_to_barbarians?
      cities.without_metropolises.empty?
    end

    def can_build_knight?(level)
      knights.level(level).size < 2
    end

    def can_promote_knight?(level)
      return false if level == 3
      knights_to_promote = knights.level(level)
      higher_level_knights = knights.level(level + 1)
      knights_to_promote.any? && higher_level_knights.size < 2
    end

  end

end
