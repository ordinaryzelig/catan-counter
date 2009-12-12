class Player < ActiveRecord::Base
  
  include ExpandedModel
  
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
      each(&:deactivate)
    end
    def strength
      map(&:strength).sum
    end
  end
  belongs_to :game
  has_one :longest_road
  has_many :soldiers
  has_one :largest_army
  # why isn't this using the inflection?
  has_many :defenders_of_catan, :class_name => 'DefenderOfCatan'
  has_many :metropolises, :through => :cities
  has_one :boot
  has_one :merchant
  has_many :progress_card_victory_points
  has_many :gold_point_victory_points
  
  delegate :expansions, :to => :game
  
  # default name to color.
  before_validation do |player|
    player.name ||= player.color
  end
  
  validates_presence_of :game_id
  validates_presence_of :name
  # custom validates_inclusion_of.
  validate do |player|
    unless player.errors.on(:game_id)
      player.errors.add(:color, 'is not in the list') unless player.game.colors.include?(player.color)
    end
  end
  validates_uniqueness_of :color, :scope => :game_id
  
  after_create :create_starter_buildings
  
  def create_starter_buildings
    2.times { settlements.create! }
  end
  
  def victory_points
    settlements.size +
    (cities.size * 2) +
    (self.longest_road(true) ? 2 : 0) +
    (self.largest_army(true) ? 2 : 0)
  end
  
  def can_build_settlement?
    settlements.left > 0
  end
  
  def can_build_city?
    settlements.any? && cities.left > 0
  end
  
  def take_longest_road
    game.longest_road.update_attributes! :player => self
  end
  
  def play_soldier
    soldier = game.soldiers.not_taken.first
    raise Soldier::NoMore unless soldier
    soldiers << soldier
  end
  
  def victory_points_needed_to_win
    game.victory_points_to_win
  end
  
  def has_enough_victory_points_to_win?
    victory_points >= victory_points_needed_to_win
  end
  
  class NoCitiesToBuildMetropolis < StandardError; end
  
end
