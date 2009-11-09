module FiveSixPlayer
  
  def self.included(game)
    game.class_eval do
      def self.colors
        ['blue', 'red', 'white', 'orange', 'green', 'brown'].freeze
      end
    end
  end
  
end
