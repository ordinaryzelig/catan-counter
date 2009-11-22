require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  
  def test_victory_points
    player = Player.make
    player.settlements.destroy_all
    player.cities.destroy_all
    2.times { player.settlements.make }
    2.times { player.cities.make }
    assert_equal 6, player.victory_points
  end
  
  def test_create_starter_buildings
    player = Player.make
    assert_equal 2, player.settlements.size
  end
  
  def test_can_build_settlement?
    player = Player.make
    player.settlements.left.times { player.settlements.make  }
    assert !player.can_build_settlement?
    player.settlements.last.destroy
    assert player.can_build_settlement?
  end
  
  def test_can_build_city?
    player = Player.make
    assert player.can_build_city?
    # no settlements to upgrade.
    player.settlements.destroy_all
    assert !player.can_build_city?
    # settlements, but no cities left.
    player.settlements.make
    assert player.can_build_city?
    player.cities.left.times { player.cities.make }
    assert !player.can_build_city?
  end
  
  def test_default_name_to_color
    color = 'blue'
    player = Player.make(:color => color, :name => nil)
    assert_equal color, player.name
  end
  
  def test_deactivate_knights
    player = Player.make
    2.times { player.knights.make(:activated => true) }
    assert !player.knights.deactivate.any?(&:activated)
  end
  
  def test_can_promote_knight?
    player = Player.make
    # no knights to promote.
    assert !player.can_promote_knight?(1)
    # one knight to promote with no other knights.
    player.knights.make(:level => 1)
    assert player.can_promote_knight?(1)
    # already has 2 level 2 knights.
    2.times { player.knights.make(:level => 2) }
    assert !player.can_promote_knight?(1)
  end
  
  def test_victory_points_with_longest_road
    player = Player.make
    player.game.create_components
    assert_difference('player.victory_points', 2) do
      player.take_longest_road
    end
  end
  
  def test_take_longest_road_from_another_player
    game = Game.make
    longest_road = game.create_longest_road
    player1, player2 = 2.times.map { game.players.make }
    assert_difference('player1.victory_points', 2) do
      player1.take_longest_road
    end
    assert_difference('player1.victory_points', -2) do
      assert_difference('player2.victory_points', 2) do
        player2.take_longest_road
      end
    end
  end
  
  def test_play_soldier
    player = Player.make
    player.game.create_components
    assert_difference('player.soldiers.size') do
      player.play_soldier
    end
  end
  
  def test_victory_points_with_largest_army
    player = Player.make
    player.game.create_components
    assert_difference('player.victory_points', 2) do
      3.times { player.play_soldier }
    end
  end
  
  def test_no_more_soldiers_to_get
    player = Player.make
    player.game.soldiers.not_taken.each { player.play_soldier }
    assert_raise(Soldier::NoMore) { player.play_soldier }
  end
  
  def test_knights_strength
    knight = Knight.make
    assert_equal 0, knight.player.knights.strength
    assert_equal 1, knight.activate.reload.player.knights.strength
    assert_equal 2, knight.promote.reload.player.knights.strength
    knight = Knight.make(:player => knight.player)
    assert_equal 2, knight.player.knights.strength
    assert_equal 3, knight.activate.reload.player.knights.strength
  end
  
  def test_can_build_metropolis?
    game = Game.make(:cities_and_knights).create_components
    player = game.players.make
    # got cities?
    assert player.can_build_metropolis?
    # git cities without metropolises?
    game.metropolises.first.update_attributes! :city => player.cities.first
    assert !player.can_build_metropolis?
    # got cities again?
    player.cities.make
    assert player.can_build_metropolis?
    # already got metropolis?
    assert !player.can_build_metropolis?(player.metropolises.first.development_area)
  end
  
  def test_metropolis_victory_points
    game = Game.make(:cities_and_knights).create_components
    player = game.players.make
    game.metropolises.first.update_attributes! :city => player.cities.first
    assert_equal 5, player.victory_points
  end
  
  def test_build_metropolis
    game = Game.make(:cities_and_knights).create_components
    player = game.players.make
    assert_difference('player.victory_points', 2) do
      assert_equal 'politics', player.build_metropolis('politics').development_area
    end
  end
  
  def test_take_boot
    game = Game.make(:fishermen_of_catan).create_components
    player = game.players.make
    player.take_boot
    assert_equal player, player.boot.player
  end
  
end
