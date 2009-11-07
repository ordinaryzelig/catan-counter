class City < ActiveRecord::Base
  
  belongs_to :player
  
  set_limit_per_player 4
  
end
