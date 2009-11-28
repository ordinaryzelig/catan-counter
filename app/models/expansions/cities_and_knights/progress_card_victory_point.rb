class ProgressCardVictoryPoint < ActiveRecord::Base
  
  belongs_to :game
  belongs_to :player
  
  validates_presence_of :game_id
  
  # check limit.
  before_create do |pcvp|
    raise LimitExceeded if pcvp.game.progress_card_victory_points.size >= ProgressCardVictoryPoint.limit_per_game
  end
  
  def self.limit_per_game
    3
  end
  
  class LimitExceeded < StandardError; end
  
end
