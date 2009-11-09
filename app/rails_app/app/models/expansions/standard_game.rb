class StandardGame < Game
  
  def self.default_victory_points_to_win
    10
  end
  
  def self.colors
    ['blue', 'red', 'white', 'orange']
  end
  
  def create_starter_buildings(player)
    2.times { player.settlements.create! }
  end
  
end
