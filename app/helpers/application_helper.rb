module ApplicationHelper

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

end
