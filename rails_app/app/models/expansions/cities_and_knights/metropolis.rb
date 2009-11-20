class Metropolis < ActiveRecord::Base
  
  DEVELOPMENT_AREAS = [:trade, :politics, :science]
  
  belongs_to :game
  belongs_to :player
  belongs_to :city
  
  named_scope :built, :conditions => "city_id is not null"
  
  validates_presence_of :game_id
  validates_presence_of :development_area
  
  # check limit.
  before_create do |metropolis|
    raise LimitExceeded if metropolis.game.metropolises.size >= Metropolis.limit_per_game
  end
  
  def self.limit_per_game
    DEVELOPMENT_AREAS.size
  end
  
  class LimitExceeded < StandardError; end
  class NoMore < StandardError; end
  
end
