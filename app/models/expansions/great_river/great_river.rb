module GreatRiver
  
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
      super + 2
    end
    
    def create_components
      create_gold_point_victory_points
      super
    end
    
    private
    
    def create_gold_point_victory_points
      GoldPointVictoryPoint.limit_per_game.times { gold_point_victory_points.create! }
    end
    
  end
  
  module PlayerMethods
    
    def victory_points
      super +
      (self.gold_point_victory_points.size)
    end
    
    def victory_points_needed_to_win
      super +
      gold_point_victory_points.size
    end
    
    def take_gold_point_victory_point
      self.gold_point_victory_points << game.gold_point_victory_points.not_taken.first
    end
    
  end
  
end
