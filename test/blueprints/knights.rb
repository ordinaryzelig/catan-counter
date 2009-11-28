Knight.blueprint do
  player { Player.make(:game => Game.make(:cities_and_knights)) }
  level { 1 }
  activated { false }
end
