class CreateExpansions < ActiveRecord::Migration
  
  def self.up
    create_table :expansions do |t|
      t.string :name, {:null => false}
      t.string :display_name, {:null => false}
      t.string :description, {:null => false}
      t.timestamps
    end
    add_index :expansions, :name, {:unique => true}
  end
  
  def self.down
    drop_table :expansions
  end
  
end
