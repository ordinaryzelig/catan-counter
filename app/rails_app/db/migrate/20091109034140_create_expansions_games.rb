class CreateExpansionsGames < ActiveRecord::Migration
  
  def self.up
    create_table :expansions_games, :id => false do |t|
      t.integer :game_id, {:null => false}
      t.integer :expansion_id, {:null => false}
      t.timestamps
    end
  end
  
  def self.down
    drop_table :expansions_games
  end
  
end
