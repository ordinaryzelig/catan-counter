Sham.development_area { Metropolis::DEVELOPMENT_AREAS.sample }

Metropolis.blueprint do
  game { Game.make(:cities_and_knights) }
  development_area
end
