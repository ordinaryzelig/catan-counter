require 'test_helper'

class CitiesAndKnightTest < ActiveSupport::TestCase

  def setup
    super
    @game = Game.make(:cities_and_knights).create_components
  end

  def test_game_uses?
    assert @game.uses?(@game.expansions.first)
    assert !@game.uses?(Expansion.make(:fishermen_of_catan))
    assert @game.uses?(CitiesAndKnights)
  end

  def test_game_default_victory_points_to_win
    assert_equal 13, @game.reload.default_victory_points_to_win
  end

  def test_player_create_starter_buildings
    player = Player.make(:game => @game)
    assert_equal 1, player.settlements.size
    assert_equal 1, player.cities.size
  end

  def test_game_victory_points_to_win
    assert_equal 13, @game.victory_points_to_win
  end

  def test_game_create_components
    # no soldiers or largest army.
    assert @game.soldiers.empty?
    assert_nil @game.largest_army
    assert_not_nil @game.longest_road
    assert_equal Metropolis.development_areas.size, @game.metropolises.size
    assert_equal DefenderOfCatan.limit_per_game, @game.defenders_of_catan.size
    assert_not_nil @game.merchant
    assert_equal ProgressCardVictoryPoint.limit_per_game, @game.progress_card_victory_points.size
  end

  def test_player_victory_points
    player = @game.players.make
    2.times { player.knights.make.activate }
    @game.barbarians.attack
    assert_equal 4, player.victory_points
    player.build_metropolis('politics')
    assert_equal 6, player.victory_points
    player.take_merchant
    assert_equal 7, player.victory_points
    player.take_progress_card_victory_point
    assert_equal 8, player.victory_points
  end

  def test_game_do_not_create_soldiers
    assert @game.soldiers.empty?
  end

  def test_player_deactivate_knights
    player = @game.players.make
    2.times { player.knights.make(:activated => true) }
    assert !player.knights.deactivate.any?(&:activated)
  end

  def test_player_can_promote_knight?
    player = @game.players.make
    # no knights to promote.
    assert !player.can_promote_knight?(1)
    # one knight to promote with no other knights.
    player.knights.make(:level => 1)
    assert player.can_promote_knight?(1)
    # already has 2 level 2 knights.
    2.times { player.knights.make(:level => 2) }
    assert !player.can_promote_knight?(1)
  end

  def test_player_take_progress_card_victory_point
    player = @game.players.make
    assert_difference('@game.reload.progress_card_victory_points.not_taken.size', -1) do
      player.take_progress_card_victory_point
    end
  end

  def test_player_can_build_metropolis?
    player = @game.players.make
    # got cities?
    assert player.can_build_metropolis?
    # git cities without metropolises?
    @game.metropolises.first.update_attributes! :city => player.cities.first
    assert !player.can_build_metropolis?
    # got cities again?
    player.cities.make
    assert player.can_build_metropolis?
    # already got metropolis?
    assert !player.can_build_metropolis?(player.metropolises.first.development_area)
  end

  def test_player_metropolis_victory_points
    player = @game.players.make
    @game.metropolises.first.update_attributes! :city => player.cities.first
    assert_equal 5, player.victory_points
  end

  def test_player_build_metropolis
    player = @game.players.make
    assert_difference('player.victory_points', 2) do
      assert_equal 'politics', player.build_metropolis('politics').development_area
    end
  end

end
