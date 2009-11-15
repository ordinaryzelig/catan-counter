class Soldier < ActiveRecord::Base
  
  belongs_to :player
  belongs_to :game
  
  validates_presence_of :game_id
  
  # check limit.
  before_create do |soldier|
    raise LimitExceeded if soldier.game.soldiers.size >= Soldier.limit_per_game
  end
  
  # award largest army?
  after_update do |soldier|
    player = soldier.player
    game = soldier.game
    next if game.largest_army.player_id == player.id
    next unless player.soldiers.size >= 3
    player_with_largest_army = game.players.with_largest_army
    if player_with_largest_army.nil? || player.soldiers.size > player_with_largest_army.soldiers.size
      game.largest_army.update_attributes! :player => player
    end
  end
  
  def self.limit_per_game
    14
  end
  
  class LimitExceeded < StandardError; end
  class NoMore < StandardError; end
  
end
