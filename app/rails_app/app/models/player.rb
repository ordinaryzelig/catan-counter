class Player < ActiveRecord::Base
  
  COLORS = ['blue', 'red', 'white', 'orange', 'brown', 'green']
  
  has_many :knights
  has_many :settlements
  has_many :cities
  has_many :roads
  belongs_to :game
  
  validates_presence_of :game_id
  validates_inclusion_of :color, :in => COLORS
  
  after_create do |player|
    player.game.create_starter_buildings(player)
  end
  
  def victory_points
    settlements.size + cities.size
  end
  
end
