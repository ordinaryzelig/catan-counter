class GoldPointVictoryPoint < ActiveRecord::Base
  
  belongs_to :game
  belongs_to :player
  
  named_scope :not_taken, :conditions => {:player_id => nil}
  
  validates_presence_of :game_id
  
  # check limit.
  before_create do |gpvp|
    raise LimitExceeded if gpvp.game.gold_point_victory_points.size >= limit_per_game
  end
  
  def self.limit_per_game
    8
  end
  
  class LimitExceeded < StandardError; end
  
end
