module LimitPerPlayer
  
  attr_reader :limit_per_player
  
  def set_limit_per_player(limit_per_player)
    @limit_per_player = limit_per_player
    validate do |record|
      player_owned_objects = record.player.send(self.name.tableize).all
      if player_owned_objects.size >= limit_per_player
        record.errors.add_to_base "player can only have #{limit_per_player} #{record.class.tableize}"
      end
    end
  end
  
end
