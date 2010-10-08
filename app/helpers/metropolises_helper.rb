module MetropolisesHelper

  def link_to_build_metropolis(player, metropolis)
    can_build_metropolis = player.can_build_metropolis?(metropolis.development_area)
    link_text = "build #{metropolis.development_area} metro."
    link_to_action_partial_if(can_build_metropolis, link_text, image_tag("metropolis_#{metropolis.development_area}.png"), :method => :put) do
      build_metropolis_player_url(player, :development_area => metropolis.development_area)
    end
  end

end
