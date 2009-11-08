class Game < ActiveRecord::Base
  
  has_many :players do
    def colors
      map &:color
    end
    def colors_left
      colors_left = proxy_owner.class.colors - colors
      def colors_left.container
        map { |color| [color, color] }
      end
      colors_left
    end
  end
  has_many :knights, :through => :players
  
  attr_accessor :game_type_attribute
  accepts_nested_attributes_for :players, :reject_if => proc { |atts| atts['name'].blank? }
  
  def self.types
    @types ||= [StandardGame].freeze
  end
  
  def self.container
    types.map { |type| [type.name.titleize, type.name] }
  end
  
end
