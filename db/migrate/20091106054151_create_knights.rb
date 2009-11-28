class CreateKnights < ActiveRecord::Migration
  
  def self.up
    create_table :knights do |t|
      t.integer :player_id, {:null => false}
      t.integer :level
      t.boolean :activated, {:default => false}
      t.timestamps
    end
  end
  
  def self.down
    drop_table :knights
  end
  
end
