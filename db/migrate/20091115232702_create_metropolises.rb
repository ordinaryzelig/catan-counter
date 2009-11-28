class CreateMetropolises < ActiveRecord::Migration
  
  def self.up
    create_table :metropolises do |t|
      t.integer :game_id, {:null => false}
      t.integer :city_id
      t.string :development_area, {:null => false}
    end
  end
  
  def self.down
    drop_table :metropolises
  end
  
end
