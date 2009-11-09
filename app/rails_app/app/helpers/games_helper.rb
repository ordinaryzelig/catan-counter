module GamesHelper
  
  def label_for_expansion(expansion)
    content = image_tag("#{expansion.display_name}.jpg", :width => '25%')
    content += '<br/>'
    content += expansion.display_name
    content_tag :label, content, :for => dom_id(expansion)
  end
  
end
