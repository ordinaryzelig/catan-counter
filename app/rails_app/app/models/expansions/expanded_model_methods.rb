module ExpandedModelMethods
  
  def self.included(base)
    base.class_eval do
      after_create :extend_expansions
    end
  end
  
  def uses?(expansion_object_or_module)
    case expansion_object_or_module
    when Expansion
      expansion_object_or_module.name.constantize
    when Module
      is_a? expansion_object_or_module
    end
  end
  
  def after_find
    extend_expansions
  end
  
  # tried overwriting extend, but that didn't work.
  def extend_expansion(expansion)
    extend expansion.name.constantize
  end
  
  def extend_expansions
    expansions.each do |expansion|
      extend_expansion expansion
    end
  end
  
  def expansion_added(expansion)
    extend_expansion expansion
    expansion_added(expansion) # this should call newly defined method in expansion module.
  end
  
end
