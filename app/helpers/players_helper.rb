module PlayersHelper

  def longest_road_image(player)
    classes = ['longestRoad']
    classes << 'hidden' unless player.longest_road
    image_tag('longest_road.png', :class => classes)
  end

end
