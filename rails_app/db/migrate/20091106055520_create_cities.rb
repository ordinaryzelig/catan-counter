class CreateCities < ActiveRecord::Migration
  
  def self.up
    create_table :cities do |t|
      t.integer :player_id, {:null => false}
      t.timestamps
    end
  end
  
  def self.down
    drop_table :cities
  end
  
end
