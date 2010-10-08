module GamesHelper

  def label_for_expansion(expansion)
    render :partial => 'expansion_label', :locals => {:expansion => expansion}
  end

end
