Sham.development_area { Metropolis::DEVELOPMENT_AREAS.rand }

Metropolis.blueprint do
  game { Game.make(:cities_and_knights) }
  development_area
end
