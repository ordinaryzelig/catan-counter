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
  
  accepts_nested_attributes_for :players, :reject_if => proc { |atts| atts['name'].blank? }
  
  def self.default_victory_points_to_win
    10
  end
  
  def self.colors
    ['blue', 'red', 'white', 'orange']
  end
  
  def create_starter_buildings(player)
    2.times { player.settlements.create! }
  end
  
end
