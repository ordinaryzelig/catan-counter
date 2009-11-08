class Player < ActiveRecord::Base
  
  COLORS = ['blue', 'red', 'white', 'orange', 'brown', 'green']
  
  has_many :settlements do
    def left
      5 - size
    end
  end
  has_many :cities do
    def left
      4 - size
    end
  end
  has_many :knights
  belongs_to :game
  
  validates_presence_of :game_id
  validates_inclusion_of :color, :in => COLORS
  validates_uniqueness_of :color, :scope => :game_id
  
  after_create do |player|
    player.game.create_starter_buildings(player)
  end
  
  def victory_points
    settlements.size + (cities.size * 2)
  end
  
  def can_build_settlement?
    settlements.left > 0
  end
  
  def can_build_city?
    settlements.any? && cities.left > 0
  end
  
end
