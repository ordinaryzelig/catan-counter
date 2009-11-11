class CreateLongestRoads < ActiveRecord::Migration
  
  def self.up
    create_table :longest_roads do |t|
      t.integer :player_id, {:null => false}
      t.timestamps
    end
  end
  
  def self.down
    drop_table :longest_roads
  end
  
end
