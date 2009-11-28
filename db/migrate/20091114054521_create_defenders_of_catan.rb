class CreateDefendersOfCatan < ActiveRecord::Migration
  
  def self.up
    create_table :defenders_of_catan do |t|
      t.integer :game_id, {:null => false}
      t.integer :player_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :defenders_of_catan
  end
  
end
