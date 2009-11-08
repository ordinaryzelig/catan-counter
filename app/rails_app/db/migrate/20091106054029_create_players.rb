class CreatePlayers < ActiveRecord::Migration
  
  def self.up
    create_table :players do |t|
      t.integer :game_id, {:null => false}
      t.string :color, {:null => false}
      t.string :name, {:null => false}
      t.timestamps
    end
  end
  
  def self.down
    drop_table :players
  end
  
end
