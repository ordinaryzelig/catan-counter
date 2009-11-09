require 'test_helper'

class CitiesAndKnightTest < ActiveSupport::TestCase
  
  def setup
    @game = Game.make(:expansions => [Expansion.make(:cities_and_knights)])
  end
  
  def test_uses?
    assert @game.uses?(CitiesAndKnights)
  end
  
  def test_default_victory_points_to_win
    assert_equal 13, @game.reload.default_victory_points_to_win
  end
  
  def test_create_starter_buildings
    player = Player.make(:game => @game)
    assert_equal 1, player.settlements.size
    assert_equal 1, player.cities.size
  end
  
end
