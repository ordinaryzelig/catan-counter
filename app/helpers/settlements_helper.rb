module SettlementsHelper

  def link_to_build_settlement(player)
    link_to_action_partial_if(player.can_build_settlement?, 'build', image_tag('add.png'), :method => :post) do
      player_settlements_url(player)
    end
  end

  def link_to_upgrade_settlement(player)
    link_to_action_partial_if(player.can_build_city?, 'upgrade', image_tag('up.png'), :method => :post, :remote => true) do
      upgrade_to_city_player_settlement_url(player, player.settlements.first)
    end
  end

  def link_to_destroy_settlement(player)
    link_to_action_partial_if(player.can_destroy_settlement?, 'destroy', image_tag('delete.png'), :method => :delete) do
      player_settlement_url(player.settlements.first)
    end
  end

end
