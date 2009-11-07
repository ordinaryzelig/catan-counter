class Settlement < ActiveRecord::Base
  
  belongs_to :player
  
  validates_presence_of :player_id
  
  set_limit_per_player 5
  
end
