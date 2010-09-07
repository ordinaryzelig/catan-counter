ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webrat'
Webrat.configure do |config|
  config.mode = :rack
  config.open_error_files = false # Set to true if you want error pages to pop up in the browser
end
require File.expand_path(File.dirname(__FILE__) + "/blueprints")

class ActiveSupport::TestCase

  def setup
    Sham.reset
  end

end
