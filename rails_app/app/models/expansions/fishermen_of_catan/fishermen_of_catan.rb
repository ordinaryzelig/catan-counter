module FishermenOfCatan
  
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
    
    def create_components
      super
      create_boot
      self
    end
    
  end
  
  module PlayerMethods
    
    def victory_points_needed_to_win
      super +
      (self.boot ? 1 : 0)
    end
    
  end
  
end
