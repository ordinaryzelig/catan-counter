class ProgressCardVictoryPoint < ActiveRecord::Base
  
  belongs_to :game
  belongs_to :player
  
  scope :not_taken, :conditions => {:player_id => nil}
  
  validates_presence_of :game_id
  
  def self.limit_per_game
    3
  end
  
end
