class CreateBoots < ActiveRecord::Migration
  
  def self.up
    create_table :boots do |t|
      t.integer :game_id, {:null => false}
      t.integer :player_id
    end
  end
  
  def self.down
    drop_table :boots
  end
  
end
