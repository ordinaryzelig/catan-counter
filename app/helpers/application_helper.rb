module ApplicationHelper

  def action_partial(action, image, disabled)
    render :partial => 'actions/action',
           :locals => {:disabled => disabled,
                       :action => action,
                       :image => image}
  end

end
