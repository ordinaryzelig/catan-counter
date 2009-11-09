class Game < ActiveRecord::Base
  
  has_many :players do
    def colors
      map &:color
    end
    def colors_left
      colors_left = proxy_owner.colors - colors
      def colors_left.container
        map { |color| [color, color] }
      end
      colors_left
    end
  end
  has_and_belongs_to_many :expansions
  
  after_create :extend_expansions
  
  accepts_nested_attributes_for :players, :reject_if => proc { |atts| atts['name'].blank? }
  
  def extend_expansions
    expansions.each do |expansion|
      extend expansion.name.constantize
    end
  end
  
  def after_find
    extend_expansions
  end
  
  def default_victory_points_to_win
    10
  end
  
  def colors
    ['blue', 'red', 'white', 'orange', 'green', 'brown'].freeze
  end
  
  def create_starter_buildings(player)
    2.times { player.settlements.create! }
  end
  
end
