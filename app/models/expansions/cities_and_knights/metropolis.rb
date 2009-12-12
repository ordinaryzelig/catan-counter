class Metropolis < ActiveRecord::Base
  
  DEVELOPMENT_AREAS = ['trade', 'politics', 'science']
  
  belongs_to :game
  belongs_to :player
  belongs_to :city
  
  named_scope :built, :conditions => "city_id is not null"
  named_scope :development_area, proc { |area| {:conditions => {:development_area => area}} }
  
  validates_presence_of :game_id
  validates_inclusion_of :development_area, :in => DEVELOPMENT_AREAS
  
  # check limit.
  before_create do |metropolis|
    raise LimitExceeded if metropolis.game.metropolises.size >= limit_per_game
  end
  
  def self.limit_per_game
    DEVELOPMENT_AREAS.size
  end
  
  class LimitExceeded < StandardError; end
  
end
