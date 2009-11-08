class City < ActiveRecord::Base
  
  belongs_to :player
  
  set_limit_per_player 4
  
  def downgrade_to_settlement
    destroy
    player.settlements.create! if player.can_build_settlement?
  end
  
end
