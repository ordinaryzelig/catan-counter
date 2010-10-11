module KnightsHelper

  def link_to_build_knight(player)
    action_label = 'build knight'
    image_file_name = 'add.png'
    url = player_knights_url(player)
    options = {:method => :post}
    link_to_action_partial_if(player.can_build_knight?(1), action_label, image_file_name, url, options)
  end

  def link_to_toggle_knight_activation(knight)
    action_label = knight.activated ? 'deactivate' : 'activate'
    image_file_name = "knights/#{knight.player.color}_#{knight.level}#{knight.activated ? '_activated' : nil}.png"
    url = toggle_activation_player_knight_url(knight.player, knight)
    options = {:method => :put}
    link_to_action_partial_if(true, action_label, image_file_name, url, options)
  end

  def link_to_promote_knight(knight)
    action_label = 'promote'
    image_file_name = 'up.png'
    url = promote_player_knight_url(knight.player, knight)
    options = {:method => :put}
    link_to_action_partial_if(knight.can_be_promoted?, action_label, image_file_name, url, options)
  end

  def link_to_destroy_knight(knight)
    action_label = 'destroy'
    image_file_name = 'delete.png'
    url = player_knight_url(knight.player, knight)
    options = {:method => :delete}
    link_to_action_partial_if(true, action_label, image_file_name, url, options)
  end

end
