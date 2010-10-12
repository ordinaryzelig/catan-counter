module SoldiersHelper

  def link_to_play_soldier(player)
    action_label = 'use'
    image_file_name = 'robber.png'
    url = play_soldier_player_url(player)
    options = {:method => :put, :class => 'use', :remote => true}
    link_to_action_partial_if(true, action_label, image_file_name, url, options)
  end

end
