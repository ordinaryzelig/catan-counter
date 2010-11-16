class LongestRoad < ActiveRecord::Base

  belongs_to :player
  belongs_to :game

  validates :game_id, :presence => true
  validates :game_id, :uniqueness => true

end
