module CitiesAndKnights
  
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
      13
    end
    
    def expansion_added(expansion)
      update_attributes! :victory_points_to_win => default_victory_points_to_win
    end
    
    # overwrite.
    def create_components
      create_longest_road
      create_metropolises
      create_defenders_of_catan
      self
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
      (metropolises.size * 2)
    end
    
  end
  
end
