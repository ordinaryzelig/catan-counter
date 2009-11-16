class DefenderOfCatan < ActiveRecord::Base
  
  belongs_to :game
  belongs_to :player
  
  validates_presence_of :game_id
  
  # check limit.
  before_create do |defender_of_catan|
    raise LimitExceeded if defender_of_catan.game.defenders_of_catan.size >= DefenderOfCatan.limit_per_game
  end
  
  def self.limit_per_game
    6
  end
  
  class LimitExceeded < StandardError; end
  
end
