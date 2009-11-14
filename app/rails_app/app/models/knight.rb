class Knight < ActiveRecord::Base
  
  LEVELS = (1..3).to_a
  
  belongs_to :player
  
  named_scope :activated, :conditions => {:activated => true}
  named_scope :level, proc { |level| {:conditions => {:level => level}} }
  
  validates_presence_of :player_id
  validates_presence_of :level
  validates_inclusion_of :activated, :in => [true, false]
  validates_inclusion_of :level, :in => LEVELS
  
  # only 2 knights per level.
  validate do |knight|
    if knight.level_changed? && knight.player.knights.level(knight.level).all.size >= 2
      knight.errors.add_to_base "player can only have 2 level #{knight.level} knights"
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
  
end
