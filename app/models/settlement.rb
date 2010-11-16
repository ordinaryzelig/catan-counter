class Settlement < ActiveRecord::Base

  belongs_to :player

  validates :player_id, :presence => true

  def upgrade_to_city
    destroy
    player.cities.create!
  end

end
