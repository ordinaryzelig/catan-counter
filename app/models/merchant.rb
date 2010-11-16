class Merchant < ActiveRecord::Base

  belongs_to :game
  belongs_to :player

  validates :game_id, :presence => true, :uniqueness => true

end
