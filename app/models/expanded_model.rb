=begin
  a model that can be expanded should include this module.
  this expands the model with each expansion module, giving it the expansions characteristics.
=end

module ExpandedModel

  def self.included(receiver)
    receiver.class_eval do
      after_create :extend_expansions
      after_find :extend_expansions
    end
  end

  # is this model expanded by given expansion?
  def uses?(expansion_object_or_module)
    case expansion_object_or_module
    when Expansion
      expansions.include?(expansion_object_or_module)
    when Module
      is_a? expansion_object_or_module
    end
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
