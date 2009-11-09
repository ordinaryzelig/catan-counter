module ExpansionModelMethods
  
  def self.included(base)
    base.class_eval do
      after_create :extend_expansions
    end
  end
  
  alias_method :uses?, :is_a?
  
  def after_find
    extend_expansions
  end
  
  def extend_expansions
    expansions.each do |expansion|
      extend expansion.name.constantize
    end
  end
  
end
