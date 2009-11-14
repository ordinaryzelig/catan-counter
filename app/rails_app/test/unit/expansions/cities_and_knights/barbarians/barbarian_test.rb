require 'test_helper'

class BarbarianTest < ActiveSupport::TestCase
  
  def test_strength
    game = Game.make(:expansions => [Expansion.make(:cities_and_knights)])
    assert_equal 0, game.barbarians.strength
    2.times.map { game.players.make }
    assert_equal 2, game.barbarians.strength
  end
  
  def test_strength_defended_against
    game = Game.make(:expansions => [Expansion.make(:cities_and_knights)])
    assert_equal 0, game.barbarians.strength_defended_against
    2.times.map { game.players.make }.each do |player|
      2.times.map { player.knights.make }.flatten.each(&:activate)
    end
    assert_equal 4, game.barbarians.strength_defended_against
  end
  
end
