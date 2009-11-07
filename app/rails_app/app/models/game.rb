class Game < ActiveRecord::Base
  
  has_many :players do
    def colors
      map &:color
    end
    def colors_left
      colors_left = Player::COLORS - colors
      def colors_left.container
        map { |color| [color, color] }
      end
      colors_left
    end
  end
  
  attr_accessor :game_type_attribute
  
  def self.types
    @types ||= [StandardGame].freeze
  end
  
  def self.container
    types.map { |type| [type.name.titleize, type.name] }
  end
  
end
