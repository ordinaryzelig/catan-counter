module ApplicationHelper

  def jquery_include_tag
    if Rails.env == 'production'
      javascript_include_tag 'http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js'
    else
      javascript_include_tag 'jquery-1.4.2.min.js'
    end
  end

  # a partial that includes an image and a label for the action.
  # if disabled, the css class 'disabled' will be added.
  def action_partial(action_label, image_file_name)
    render 'actions/action',
           :action_label => action_label,
           :image_file_name => image_file_name
  end

  # Customized link_to_if for an action partial.
  # If condition is false, add disabled class.
  def link_to_action_partial_if(condition, action_label, image_file_name, url, options = {})
    unless condition
      options[:class] = options[:class].blank? ? '' : options[:class] + ' '
      options[:class] += 'disabled'
    end
    link_to action_partial(action_label, image_file_name), url, options
  end

  # Javascript builder to update flash through AJAX.
  # If flash type doesn't exist, replace with empty string so previous message will go away.
  def update_flash
    ['notice', 'error'].each do |type|
      concat_js "updateFlash('#{type}', '#{flash[type]}')"
      flash.discard
    end
  end

  def get_player(player)
    "getPlayer('#{player.id}')"
  end

  # return javascript string for whether player has won or has been stripped of winner status.
  def handle_winner_status(player)
    player_js = "getPlayer('#{player.id}')"
    if player.has_enough_victory_points_to_win?
      concat_js "#{player_js}.hasEnoughVictoryPointsToWin()"
      concat_js "alert('#{player.name} has enough victory points to win.')"
    else
      concat_js "#{player_js}.noLongerHasEnoughVictoryPointsToWin()"
    end
  end

  def concat_js(javascript)
    concat javascript + "\n"
  end

  def metropolis_image_tag(development_area)
    image_tag("metropolis_#{development_area}.png", :id => "metropolis_#{development_area}", :width => '10%')
  end

end
