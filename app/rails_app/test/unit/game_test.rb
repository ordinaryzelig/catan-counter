require 'test_helper'

class GameTest < ActiveSupport::TestCase
  
  def test_players_colors_left
    game = Game.make
    game.colors[0...-1].each do |color|
      game.players.make(:color => color)
    end
    assert_equal [game.colors.last], game.players.colors_left
  end
  
  def test_player_by_color
    player = [:blue, :red].map { |color| Player.make(color) }.first
    game = player.game
    assert_equal player, game.players.send('blue')
    assert_equal player, game.players.blue
  end
  
  def test_create_players_through_attributes
    player = Player.make_unsaved(:name => 'asdf')
    game = Game.make
    game.players_attributes = {0 => player.attributes, 1 => {:name => ''}}
    assert game.valid?
    game.save!
    players = Player.find(game.players)
    assert_equal 1, players.size
    assert_equal player.name, players.first.name
  end
  
  def test_edit_players_through_attributes
    game = Player.make(:name => 'asdf', :color => 'blue').game
    new_name = 'fdsa'
    game.update_attributes!(:players_attributes => {0 => {:color => 'blue', :name => new_name}})
    assert_equal new_name, game.reload.players.blue.name
  end
  
  def test_reached_victory_points_to_win
    game = Game.make
    2.times { game.players.make }
    player = game.players.first
    player.win
    assert_equal [player], game.players.reached_victory_points_to_win
  end
  
  def test_create_longest_road
    assert Game.make.longest_road.id
  end
  
  def test_players_with_longest_road
    game = Game.make
    assert_equal game.longest_road.player, game.player_with_longest_road
  end
  
end
