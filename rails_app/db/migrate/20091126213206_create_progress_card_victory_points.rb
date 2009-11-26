class CreateProgressCardVictoryPoints < ActiveRecord::Migration
  
  def self.up
    create_table :progress_card_victory_points do |t|
      t.integer :game_id, {:null => false}
      t.integer :player_id
    end
  end
  
  def self.down
    drop_table :progress_card_victory_points
  end
  
end
