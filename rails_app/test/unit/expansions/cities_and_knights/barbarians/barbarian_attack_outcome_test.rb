require 'test_helper'

class BarbarianAttackOutcomeTest < ActiveSupport::TestCase
  
  def setup
    super
    @game = Game.make(:expansions => [Expansion.make(:cities_and_knights)])
    2.times.map { @game.players.make }
  end
  
  def test_attack_and_barbarians_win
    assert @game.cities.size > @game.knights.activated.size
    outcome = @game.barbarians.attack
    assert outcome.barbarians_are_victorious?
    assert_equal 2, outcome.strength_of_victorious_party
    assert_equal 0, outcome.strength_of_defeated_party
  end
  
  def test_attack_and_settlers_successfully_defend_with_defender_of_catan
    player = @game.players.first
    2.times { player.knights.make.activate }
    assert_difference('player.reload.victory_points') do
      outcome = @game.barbarians.attack
      assert outcome.catan_is_saved?
      assert_equal 2, outcome.strength_of_victorious_party
      assert_equal 2, outcome.strength_of_defeated_party
      assert_equal player, outcome.defender_of_catan
    end
  end
  
  def test_attack_and_settlers_successfully_defend_with_multiple_players_defending
    @game.players.each { |player| player.knights.make.activate }
    outcome = @game.barbarians.attack
    assert outcome.catan_is_saved?
    assert_equal 2, outcome.strength_of_victorious_party
    assert_equal 2, outcome.strength_of_defeated_party
    assert_equal @game.players, outcome.players_with_strongest_army
  end
  
  def test_attack_deactivates_all_knights
    @game.players.each { |player| player.knights.make.activate }
    @game.barbarians.attack
    assert @game.reload.players.all? { |player| player.knights.none?(&:activated) }
  end
  
end
