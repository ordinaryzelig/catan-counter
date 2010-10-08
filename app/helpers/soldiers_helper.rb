module SoldiersHelper

  def link_to_play_soldier(player)
    link_to(action_partial('play', image_tag('add.png'), false), play_soldier_player_url(player), :method => :put)
  end

end
