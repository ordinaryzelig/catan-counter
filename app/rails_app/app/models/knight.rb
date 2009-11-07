class Knight < ActiveRecord::Base
  
  belongs_to :player
  
  named_scope :activated, :conditions => {:activated => true}
  named_scope :level, proc { |level| {:conditions => {:level => level}} }
  
  validates_presence_of :player_id
  validates_presence_of :level
  validates_inclusion_of :activated, :in => [true, false]
  
  validate do |knight|
    if knight.player.knights.level(knight.level).all.size >= 2
      knight.errors.add_to_base "player can only have 2 level #{knight.level} knights"
    end
  end
  
end
