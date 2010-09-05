class Settlement < ActiveRecord::Base
  
  belongs_to :player
  
  validates_presence_of :player_id
  
  def upgrade_to_city
    destroy
    player.cities.create!
  end
  
end
