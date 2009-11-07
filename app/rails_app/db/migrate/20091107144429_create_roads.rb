class CreateRoads < ActiveRecord::Migration
  
  def self.up
    create_table :roads do |t|
      t.integer :player_id, {:null => false}
      t.timestamps
    end
  end
  
  def self.down
    drop_table :roads
  end
  
end
