class CreateLongestRoads < ActiveRecord::Migration
  
  def self.up
    create_table :longest_roads do |t|
      t.integer :game_id, {:null => false}
      t.integer :player_id
      t.timestamps
    end
    add_index :longest_roads, :game_id, {:unique => true}
  end
  
  def self.down
    drop_table :longest_roads
  end
  
end
