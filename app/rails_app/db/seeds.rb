require 'rubygems'
require 'test/blueprints'

[:cities_and_knights].each do |expansion|
  Expansion.make expansion
end
