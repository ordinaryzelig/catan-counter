class StandardGame < Game
  
  DEFAULT_VICTORY_POINTS_TO_WIN = 10
  
  def create_starter_buildings(player)
    2.times { player.settlements.create! }
  end
  
end
