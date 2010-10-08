module ApplicationHelper

  # a partial that includes an image and a label for the action.
  # if disabled, the css class 'disabled' will be added.
  def action_partial(action_label, image, disabled = false)
    render :partial => 'actions/action',
           :locals => {:disabled => disabled,
                       :action => action_label,
                       :image => image}
  end

  # Customized link_to_if for an action partial.
  # The block will contain the code for generating the URL.
  # some URLs will raise exception, so put them in a block that may or may not be executed.
  def link_to_action_partial_if(condition, action_label, image, options = {}, &block)
    url = condition ? block.call : nil
    if condition
      link_to action_partial(action_label, image), url, options
    else
      action_partial(action_label, image, true)
    end
  end
end
