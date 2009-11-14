class Game < ActiveRecord::Base
  
  include ExpandedModelMethods
  
  has_many :players do
    def colors
      map(&:color)
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
    def with_largest_army
      detect(&:largest_army)
    end
    def with_strongest_army
      strongest_army = 1
      inject([]) do |defenders, player|
        case player.knights.strength <=> strongest_army
        when 0
          defenders << player
        when 1
          strongest_army = player.knights.strength
          defenders = [player]
        end
        defenders
      end
    end
    def with_weakest_army
      weakest_army = 18
      reject { |player| player.cities.empty? }.inject([]) do |victims, player|
        case player.knights.strength <=> weakest_army
        when 0
          victims << player
        when -1
          weakest_army = player.knights.strength
          victims = [player]
        end
        victims
      end
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
  has_one :longest_road
  has_one :largest_army
  has_many :soldiers do
    def not_taken
      reject(&:player_id)
    end
  end
  has_many :cities, :through => :players
  has_many :knights, :through => :players
  
  # assign default victory points.
  before_validation do |game|
    game.extend_expansions
    game.victory_points_to_win ||= game.default_victory_points_to_win
  end
  
  validates_numericality_of :victory_points_to_win
  
  # save players from players_attributes.
  after_save do |game|
    game.players.save! if game.players_attributes_changed
  end
  after_save :create_longest_road
  after_save :create_largest_army
  # create soldiers.
  after_create do |game|
    Soldier.limit_per_game.times { game.soldiers.create! }
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
  
  def player_with_longest_road
    longest_road.player
  end
  
  def barbarians
    @barbarians ||= Barbarians.new(self)
  end
  
end
