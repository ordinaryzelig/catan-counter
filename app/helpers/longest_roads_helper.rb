module LongestRoadsHelper

  def link_to_take_longest_road(player)
    options = {:method => :put, :remote => true}
    classes = ['longestRoad']
    classes << 'hidden' if player.longest_road
    options[:class] = classes
    link_to 'take longest road', take_longest_road_player_url(player), options
  end

end
