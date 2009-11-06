class Knight < ActiveRecord::Base
  
  named_scope :activated, :conditions => {:activated => true}
  named_scope :level, proc { |level| {:conditions => {:level => level}} }
  
end
