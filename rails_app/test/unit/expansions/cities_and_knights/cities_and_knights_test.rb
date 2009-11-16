require 'test_helper'

class CitiesAndKnightTest < ActiveSupport::TestCase
  
  def setup
    @game = Game.make(:cities_and_knights).create_components
  end
  
  def test_uses?
    assert @game.uses?(@game.expansions.first)
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
  
  def test_victory_points_to_win
    game = Game.make
    assert_equal 10, game.victory_points_to_win
    game.expansions << Expansion.make(:cities_and_knights)
    assert_equal 13, game.victory_points_to_win
  end
  
  def test_player_victory_points
    player = @game.players.make
    2.times { player.knights.make.activate }
    @game.barbarians.attack
    assert_equal 4, player.victory_points
  end
  
  def test_create_defenders_of_catan
    assert_equal DefenderOfCatan.limit_per_game, @game.defenders_of_catan.size
  end
  
  def test_create_metropolises
    assert_equal Metropolis::DEVELOPMENT_AREAS.size, @game.metropolises.size
  end
  
  def test_do_not_create_soldiers
    assert @game.soldiers.empty?
  end
  
end
