module KnightsHelper

  def link_to_build_knight(player)
    action_label = 'build knight'
    image_file_name = 'add.png'
    url = player_knights_url(player)
    options = {:class => 'buildKnight', :remote => true, :method => :post}
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
    options = {:method => :put, :remote => true}
    link_to_action_partial_if(knight.can_be_promoted?, action_label, image_file_name, url, options)
  end

  def link_to_destroy_knight(knight)
    action_label = 'remove'
    image_file_name = 'delete.png'
    url = player_knight_url(knight.player, knight)
    options = {:method => :delete, :remote => true}
    link_to_action_partial_if(true, action_label, image_file_name, url, options)
  end

  # AJAX to remove knight by id.
  def remove_knight(knight)
    "$('#knight_' + #{knight.id}).remove()"
  end

  # AJAX to add knight to player depending on level.
  def add_knight(knight)
    "addKnight(#{knight.level}, '#{escape_javascript(render(@knight))}')".html_safe
  end

end
