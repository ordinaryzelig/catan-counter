class DefenderOfCatan < ActiveRecord::Base

  belongs_to :game
  belongs_to :player

  scope :not_taken, where(:player_id => nil)

  validates_presence_of :game_id

  def self.limit_per_game
    8
  end

end
