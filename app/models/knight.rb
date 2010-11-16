class Knight < ActiveRecord::Base

  LEVELS = (1..3).to_a

  belongs_to :player

  scope :activated, where(:activated => true)
  scope :level, proc { |level| where(:level => level) }

  validates :player_id, :presence => true
  validates :level, :presence => true, :inclusion => LEVELS
  validates :activated, :inclusion => [true, false]

  # only 2 knights per level.
  validate do |knight|
    if knight.level_changed? && knight.player.knights.level(knight.level).all.size >= 2
      knight.errors.add(:base, "player can only have 2 level #{knight.level} knights")
    end
  end

  def promote
    update_attributes! :level => level + 1
    self
  end

  def activate
    update_attributes! :activated => true
    self
  end

  def deactivate
    update_attributes! :activated => false
    self
  end

  def toggle_activation
    activated ? deactivate : activate
  end

  def strength
    activated ? level : 0
  end

  def can_be_promoted?
    return false if level == 3
    return false if player.knights.level(level + 1).size == 2
    return true
  end

end
