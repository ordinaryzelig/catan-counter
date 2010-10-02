class Soldier < ActiveRecord::Base

  belongs_to :game
  belongs_to :player

  scope :not_taken, where(:player_id => nil)

  validates_presence_of :game_id

  # award largest army?
  after_update do |soldier|
    player = soldier.player
    game = soldier.game
    next if player.largest_army
    next unless player.soldiers.size >= 3
    if player.has_more_soldiers_than?(game.players.with_largest_army)
      game.largest_army.update_attributes! :player => player
    end
  end

  def self.limit_per_game
    20
  end

end
