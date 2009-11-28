class CreatePlayers < ActiveRecord::Migration
  
  def self.up
    create_table :players do |t|
      t.integer :game_id, {:null => false}
      t.string :color, {:null => false}
      t.string :name, {:null => false}
      t.timestamps
    end
    add_index :players, [:game_id, :color], :unique => true
  end
  
  def self.down
    drop_table :players
  end
  
end
