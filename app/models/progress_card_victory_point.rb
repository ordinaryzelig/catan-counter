class ProgressCardVictoryPoint < ActiveRecord::Base

  belongs_to :game
  belongs_to :player

  scope :not_taken, where(:player_id => nil)

  validates :game_id, :presence => true

  def self.limit_per_game
    3
  end

end
