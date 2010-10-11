module MetropolisesHelper

  def link_to_build_metropolis(player, metropolis)
    action_label = "build #{metropolis.development_area} metro."
    image_file_name = "metropolis_#{metropolis.development_area}.png"
    url = build_metropolis_player_url(player, :development_area => metropolis.development_area)
    options = {:method => :put, :class => metropolis.development_area}
    can_build_metropolis = player.can_build_metropolis?(metropolis.development_area)
    link_to_action_partial_if(can_build_metropolis, action_label, image_file_name, url, options)
  end

end
