class CreateMerchants < ActiveRecord::Migration
  
  def self.up
    create_table :merchants do |t|
      t.integer :game_id, {:null => false}
      t.integer :player_id
    end
  end
  
  def self.down
    drop_table :merchants
  end
  
end
