class Expansion < ActiveRecord::Base
  
  EXPANSIONS = [:cities_and_knights, :fishermen_of_catan]
  
  def module
    name.constantize
  end
  
end
