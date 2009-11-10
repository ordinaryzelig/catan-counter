module GamesHelper
  
  def label_for_expansion(expansion)
    render :partial => 'expansions/label', :locals => {:expansion => expansion}
  end
  
end
