class Expansion < ActiveRecord::Base
  
  EXPANSIONS = [:cities_and_knights, :fishermen_of_catan, :great_river]
  
  def module
    name.constantize
  end
  
end
