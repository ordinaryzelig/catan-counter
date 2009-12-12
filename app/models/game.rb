class Game < ActiveRecord::Base
  
  include ExpandedModel
  
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
    def with_enough_victory_points_to_win
      self.select { |player| player.has_enough_victory_points_to_win? }
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
      # start with greatest possible strength of activated knights and work down.
      weakest_army = 18
      reject { |player| player.immune_to_barbarians? }.inject([]) do |victims, player|
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
  has_and_belongs_to_many :expansions, :after_add => [:extend_expansion, :expansion_added]
  has_many :knights, :through => :players
  has_many :cities, :through => :players
  has_one :longest_road
  has_one :largest_army
  has_many :defenders_of_catan, :class_name => 'DefenderOfCatan'
  has_many :soldiers
  has_many :metropolises, :class_name => 'Metropolis' do
    # looks like named_scope but just returns first.
    def development_area(area)
      super.first
    end
  end
  has_one :boot
  has_one :merchant
  has_many :progress_card_victory_points
  has_many :gold_point_victory_points
  
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
  
  def create_components
    create_longest_road
    create_largest_army
    create_soldiers
    self
  end
  
  private
  
  # expansion module can override this.
  def expansion_added(expansion)
  end
  
  def create_soldiers
    Soldier.limit_per_game.times { soldiers.create! }
  end
  
end
