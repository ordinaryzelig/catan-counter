class Metropolis < ActiveRecord::Base
  
  DEVELOPMENT_AREAS = ['trade', 'politics', 'science']
  
  belongs_to :game
  belongs_to :player
  belongs_to :city
  
  scope :built, :conditions => "city_id is not null"
  scope :development_area, proc { |area| {:conditions => {:development_area => area}} }
  
  validates_presence_of :game_id
  validates_inclusion_of :development_area, :in => DEVELOPMENT_AREAS
  
  def self.limit_per_game
    DEVELOPMENT_AREAS.size
  end
  
end
