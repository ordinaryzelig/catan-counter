class Metropolis < ActiveRecord::Base
  
  DEVELOPMENT_AREAS = [:trade, :politics, :science]
  
  belongs_to :game
  belongs_to :city
  
  # check limit.
  before_create do |soldier|
    raise LimitExceeded if soldier.game.soldiers.size >= Soldier.limit_per_game
  end
  
  class LimitExceeded < StandardError; end
  
end
