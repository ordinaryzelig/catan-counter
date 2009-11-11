class Soldier < ActiveRecord::Base
  
  belongs_to :player
  belongs_to :game
  
  before_create do |soldier|
    raise LimitExceeded if soldier.game.soldiers.size >= Soldier.limit_per_game
  end
  
  def self.limit_per_game
    14
  end
  
  class LimitExceeded < StandardError; end
  
end
