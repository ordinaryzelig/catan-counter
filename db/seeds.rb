require "#{Rails.root}/test/blueprints"

Expansion::EXPANSIONS.each do |expansion|
  Expansion.make expansion
end
