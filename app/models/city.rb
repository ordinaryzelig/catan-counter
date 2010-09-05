class City < ActiveRecord::Base

  belongs_to :player
  has_one :metropolis

  scope :without_metropolises, :conditions => "#{Metropolis.table_name}.city_id is null", :include => :metropolis

  validate :limit_to_4

  def downgrade_to_settlement
    destroy
    player.settlements.create! if player.can_build_settlement?
  end

  private

  def limit_to_4
    errors.add(:base, 'player has no more cities to build.') if player.cities.size >= 4
  end

end
