require 'rubygems'
require 'test/blueprints'

[:five_six_player, :cities_and_knights].each do |expansion|
  Expansion.make expansion
end
