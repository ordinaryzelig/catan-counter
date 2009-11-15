class CreateLargestArmies < ActiveRecord::Migration
  
  def self.up
    create_table :largest_armies do |t|
      t.integer :game_id, {:null => false}
      t.integer :player_id
    end
  end
  
  def self.down
    drop_table :largest_armies
  end
  
end
