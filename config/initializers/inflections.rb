# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format 
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
  
  inflect.plural 'defender_of_catan', 'defenders_of_catan'
  inflect.singular 'defenders_of_catan', 'defender_of_catan'
  
  inflect.plural 'metropolis', 'metropolises'
  inflect.singular 'metropolises', 'metropolis'
  
  inflect.uncountable 'cities_and_knights'
  
end
