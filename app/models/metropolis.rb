class Metropolis < ActiveRecord::Base

  def self.development_areas
    @development_areas ||= ['trade', 'politics', 'science'].freeze
  end

  belongs_to :game
  belongs_to :city

  scope :built, where("city_id is not null")
  scope :development_area, proc { |area| where(:development_area => area) }

  validates_presence_of :game_id
  validates_inclusion_of :development_area, :in => development_areas

  def player
    city.try(:player)
  end

end
