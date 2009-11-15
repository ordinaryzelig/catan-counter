class CreateSoldiers < ActiveRecord::Migration
  
  def self.up
    create_table :soldiers do |t|
      t.integer :game_id, {:null => false}
      t.integer :player_id
    end
  end
  
  def self.down
    drop_table :soldiers
  end
  
end
