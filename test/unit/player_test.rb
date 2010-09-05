require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  def test_victory_points
    player = Player.make
    assert_equal 2, player.victory_points
    2.times { player.settlements.make }
    assert_equal 4, player.victory_points
    player.settlements.each(&:upgrade_to_city)
    assert_equal 8, player.reload.victory_points
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
      3.times { player.reload.play_soldier }
    end
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

end
