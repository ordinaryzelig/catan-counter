module PlayersHelper

  def longest_road_image(player)
    classes = ['longestRoad']
    classes << 'hidden' unless player.longest_road
    image_tag('longest_road.png', :class => classes)
  end

  def link_to_take_progress_card_victory_point(player)
    options = {:method => :put, :remote => true}
    options[:class] = 'disabled' if player.game.progress_card_victory_points.not_taken.empty?
    link_to 'take progress card victory point', take_progress_card_victory_point_player_url(player), options
  end

  def take_progress_card_victory_point
    image = escape_javascript(image_tag('victory_point.png'))
    "bonuses().append('#{image}')".html_safe
  end

end
