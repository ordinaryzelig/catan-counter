module CitiesAndKnights
  
  def self.extended(object)
    case object
    when ::Game
      object.extend Game
    when ::Player
      object.extend Player
    else
      raise "don't know how to extend #{object.class} with expansion"
    end
  end
  
  module Game
    
    def default_victory_points_to_win
      13
    end
    
  end
  
  module Player
    
    def create_starter_buildings
      settlements.create!
      cities.create!
    end
    
  end
  
end