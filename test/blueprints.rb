require 'machinist/active_record'
require 'sham'
blueprints_dir = Rails.root + 'test/blueprints'
Dir.entries(blueprints_dir).reject { |entry| entry =~ /^\./ }.each do |entry|
  require "#{blueprints_dir}/#{entry}"
end
