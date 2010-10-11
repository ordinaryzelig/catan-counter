module CitiesHelper

  def link_to_downgrade_city(player)
    action_label = 'downgrade'
    image_file_name = 'down.png'
    url = player_cities_downgrade_to_settlement_url(player)
    options = {:method => :post, :class => 'downgrade', :remote => true}
    link_to_action_partial_if(player.can_downgrade_city?, action_label, image_file_name, url, options)
  end

end
