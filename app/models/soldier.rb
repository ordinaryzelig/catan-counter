class Soldier < ActiveRecord::Base

  belongs_to :game
  belongs_to :player
  attr_accessor :acquired_largest_army

  scope :not_taken, where(:player_id => nil)

  validates :game_id, :presence => true

  # award largest army?
  after_update do |soldier|
    player = soldier.player
    # Skip if no player.
    # There wouldn't be a player if, for example, this soldier was being unassigned.
    next unless player
    game = soldier.game
    next if player.largest_army
    next unless player.soldiers.size >= 3
    if player.has_more_soldiers_than?(game.player_with_largest_army)
      game.largest_army.update_attributes! :player => player
      soldier.acquired_largest_army = true
    end
  end

  def self.limit_per_game
    20
  end

end
