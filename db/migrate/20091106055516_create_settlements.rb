class CreateSettlements < ActiveRecord::Migration
  
  def self.up
    create_table :settlements do |t|
      t.integer :player_id, {:null => false}
      t.timestamps
    end
  end
  
  def self.down
    drop_table :settlements
  end
  
end
