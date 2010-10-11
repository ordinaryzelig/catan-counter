module SettlementsHelper

  def link_to_build_settlement(player)
    action_label = 'build'
    image_file_name = 'add.png'
    url = player_settlements_url(player)
    options = {:method => :post, :class => 'build'}
    link_to_action_partial_if(player.can_build_settlement?, action_label, image_file_name, url, options)
  end

  def link_to_upgrade_settlement(player)
    action_label = 'upgrade'
    image_file_name = 'up.png'
    url = upgrade_to_city_player_settlements_url(player)
    options = {:method => :post, :remote => true, :class => 'upgrade'}
    link_to_action_partial_if(player.can_build_city?, action_label, image_file_name, url, options)
  end

  def link_to_destroy_settlement(player)
    action_label = 'destroy'
    image_file_name = 'delete.png'
    url = player_settlements_url(player)
    options = {:method => :delete, :class => 'destroy'}
    link_to_action_partial_if(player.can_destroy_settlement?, action_label, image_file_name, url, options)
  end

end
