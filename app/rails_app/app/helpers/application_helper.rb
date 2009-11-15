# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def action_partial(action, image, disabled)
    render :partial => 'actions/action',
           :locals => {:disabled => disabled,
                       :action => action,
                       :image => image}
  end
  
  def knight_image(knight)
    image_tag("knights/#{knight.player.color}_#{knight.level}#{knight.activated ? '_activated' : nil}.png", :width => '15%')
  end
  
end
