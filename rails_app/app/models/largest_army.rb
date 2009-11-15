class LargestArmy < ActiveRecord::Base
  
  belongs_to :player
  belongs_to :game
  
  validates_presence_of :game_id
  validates_uniqueness_of :game_id
  
end
