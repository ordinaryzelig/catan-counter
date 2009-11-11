class LongestRoad < ActiveRecord::Base
  
  belongs_to :player
  has_one :game, :through => :player
  
  validates_presence_of :player_id
  # each game should only have 1 longest road.
  validate_on_create do |longest_road|
    unless longest_road.errors.on(:player_id)
      # for some reason, you can't get to game using has_one :through.
      if longest_road.player.game.players.with_longest_road
        longest_road.errors.add_to_base("This game already has a longest road.")
      end
    end
  end
  
end
