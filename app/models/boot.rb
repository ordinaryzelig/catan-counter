class Boot < ActiveRecord::Base

  belongs_to :game
  belongs_to :player

  validates :game_id, :presence => true
  validates :game_id, :uniqueness => true

end
