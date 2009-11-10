module ExpansionModelMethods
  
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
  
  def extend_expansions
    expansions.each do |expansion|
      extend expansion.name.constantize
    end
  end
  
end
