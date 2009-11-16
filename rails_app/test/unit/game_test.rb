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
    game = Game.make
    game.create_components
    assert game.longest_road.id
  end
  
  def test_create_largest_army
    game = Game.make
    game.create_components
    assert game.largest_army.id
  end
  
  def test_players_with_longest_road
    game = Game.make
    game.create_components
    assert_equal game.longest_road.player, game.player_with_longest_road
  end
  
  def test_create_soldiers
    game = Game.make
    game.create_components
    assert_equal Soldier.limit_per_game, game.soldiers.size
  end
  
  def test_soldiers_not_taken
    player = Player.make
    player.game.create_components
    assert_difference('player.game.soldiers.not_taken.size', -1) do
      player.play_soldier
    end
  end
  
  def test_players_with_strongest_army
    game = Game.make(:cities_and_knights)
    players = 2.times.map { game.players.make }
    players.each do |player|
      2.times.map { player.knights.make }.flatten.each(&:activate)
    end
    assert_equal players, game.players.with_strongest_army
    defender = players.first
    defender.knights.first.promote
    assert_equal [defender], game.reload.players.with_strongest_army
  end
  
  def test_players_with_weakest_army
    game = Game.make(:cities_and_knights)
    players = 2.times.map { game.players.make }
    players.each do |player|
      2.times.map { player.knights.make }.flatten.each(&:activate)
    end
    assert_equal players, game.players.with_weakest_army
    defender = players.first
    defender.knights.first.promote
    assert_equal (players - [defender]), game.reload.players.with_weakest_army
  end
  
end
