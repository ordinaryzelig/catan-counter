module ExpandedModelMethods
  
  def self.included(base)
    base.class_eval do
      after_create :extend_expansions
    end
  end
  
  # is this model expanded by given expansion?
  def uses?(expansion_object_or_module)
    case expansion_object_or_module
    when Expansion
      expansion_object_or_module.name.constantize
    when Module
      is_a? expansion_object_or_module
    end
  end
  
  # every fetched object should extend expansions.
  def after_find
    extend_expansions
  end
  
  # tried overwriting extend, but that didn't work.
  def extend_expansion(expansion)
    extend expansion.module
  end
  
  def extend_expansions
    expansions.each do |expansion|
      extend_expansion expansion
    end
  end
  
end
