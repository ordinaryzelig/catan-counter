module KnightsHelper

  def link_to_build_knight(player)
    link_to_action_partial_if(player.can_build_knight?(1), 'build knight', image_tag('add.png'), :method => :post) do
      player_knights_url(player)
    end
  end

  def link_to_toggle_knight_activation(knight)
    knight_image_name = "knights/#{knight.player.color}_#{knight.level}#{knight.activated ? '_activated' : nil}.png"
    link_text = knight.activated ? 'deactivate' : 'activate'
    link_to(action_partial(link_text, image_tag(knight_image_name)), toggle_activation_player_knight_url(knight.player, knight), :method => :put)
  end

  def link_to_promote_knight(knight)
    link_to_action_partial_if(knight.can_be_promoted?, 'promote', image_tag('up.png'), :method => :put) { promote_player_knight_url(knight.player, knight) }
  end

  def link_to_destroy_knight(knight)
    link_to(action_partial('destroy', image_tag('delete.png')), player_knight_url(knight.player, knight), :method => :delete)
  end

end
