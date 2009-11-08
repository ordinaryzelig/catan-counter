class Player < ActiveRecord::Base
  
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
  has_many :knights do
    def deactivate
      each &:deactivate
    end
  end
  belongs_to :game
  
  # default name to color.
  before_validation do |player|
    player.name ||= player.color
  end
  
  validates_presence_of :game_id
  validates_presence_of :name
  # custom validates_inclusion_of.
  validate do |player|
    unless player.errors.on(:game_id)
      player.add(:color, 'is not in the list') unless player.game.class.colors.include?(player.color)
    end
  end
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
  
  def can_build_knight?(level)
    knights.level(level).size < 2
  end
  
  def can_promote_knight?(level)
    return false if level == 3
    knights_to_promote = knights.level(level)
    higher_level_knights = knights.level(level + 1)
    knights_to_promote.any? && higher_level_knights.size < 2
  end
  
end
