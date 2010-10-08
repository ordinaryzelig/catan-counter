module CitiesHelper

  def link_to_downgrade_city(player)
    link_to_action_partial_if(player.can_downgrade_city?, 'downgrade', image_tag('down.png'), :method => :post) do
      downgrade_to_settlement_player_city_url(player, player.cities.without_metropolises.first)
    end
  end

end
