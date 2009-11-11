class Game < ActiveRecord::Base
  
  include ExpandedModelMethods
  
  has_many :players do
    def colors
      map &:color
    end
    def colors_left
      colors_left = proxy_owner.colors - colors
      def colors_left.container
        map { |color| [color, color] }
      end
      colors_left
    end
    def save!
      each(&:save!)
    end
    def reached_victory_points_to_win
      self.select { |player| player.victory_points >= proxy_owner.victory_points_to_win }
    end
    def with_longest_road
      detect(&:longest_road)
    end
    # override method_missing and send so that we can do either of the following:
    # game.players.blue
    # game.players.send('blue')
    def method_missing(method, *args)
      is_game_color?(method) ? player_using_color(method) : super
    end
    def send(method, *args)
      is_game_color?(method) ? player_using_color(method) : super
    end
    private
    def is_game_color?(color)
      game = proxy_owner
      game.colors.include?(color.to_s)
    end
    def player_using_color(color)
      load_target
      proxy_target.detect { |player| player.color == color.to_s }
    end
  end
  has_and_belongs_to_many :expansions, :after_add => :expansion_added
  has_many :knights, :through => :players
  
  delegate :longest_road, :to => 'players.with_longest_road', :allow_nil => true
  
  before_validation do |game|
    game.extend_expansions
    game.victory_points_to_win ||= game.default_victory_points_to_win
  end
  
  validates_numericality_of :victory_points_to_win
  
  after_save do |game|
    game.players.save! if game.players_attributes_changed
  end
  
  attr_reader :players_attributes_changed
  
  # custom accepts_nested_attributes_for.
  # this is because we have to find the player by their color.
  # also, accepts_nested_attributes_for doesn't work for editing.
  def players_attributes=(players_atts)
    @players_attributes_changed = true
    players_atts.reject do |i, atts|
      atts.stringify_keys!
      atts['name'].blank?
    end.each do |i, atts|
      player = players.send(atts['color'])
      if player
        player.attributes = atts
      else
        players.build(atts)
      end
    end
  end
  
  def default_victory_points_to_win
    10
  end
  
  def self.colors
    ['blue', 'red', 'white', 'orange', 'green', 'brown'].freeze
  end
  
  def colors
    self.class.colors
  end
  
end
