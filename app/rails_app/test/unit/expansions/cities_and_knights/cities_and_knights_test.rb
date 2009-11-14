require 'test_helper'

class CitiesAndKnightTest < ActiveSupport::TestCase
  
  def test_uses?
    default_game_with_expansion
    assert @game.uses?(@expansion)
    assert @game.uses?(CitiesAndKnights)
  end
  
  def test_default_victory_points_to_win
    default_game_with_expansion
    assert_equal 13, @game.reload.default_victory_points_to_win
  end
  
  def test_create_starter_buildings
    default_game_with_expansion
    player = Player.make(:game => @game)
    assert_equal 1, player.settlements.size
    assert_equal 1, player.cities.size
  end
  
  def test_victory_points_to_win
    game = Game.make
    assert_equal 10, game.victory_points_to_win
    game.expansions << Expansion.make(:cities_and_knights)
    assert_equal 13, game.victory_points_to_win
  end
  
  def test_player_victory_points
    default_game_with_expansion
    player = @game.players.make
    2.times { player.knights.make.activate }
    @game.barbarians.attack
    assert_equal 4, player.victory_points
  end
  
  # ===================================================
  # helpers.
  
  def default_game_with_expansion
    @expansion = Expansion.make(:cities_and_knights)
    @game = Game.make(:expansions => [@expansion])
  end
  
end
