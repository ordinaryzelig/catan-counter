class City < ActiveRecord::Base
  
  belongs_to :player
  has_one :metropolis
  
  named_scope :without_metropolises, :conditions => "#{Metropolis.table_name}.city_id is null", :include => :metropolis
  
  set_limit_per_player 4
  
  def downgrade_to_settlement
    destroy
    player.settlements.create! if player.can_build_settlement?
  end
  
end
