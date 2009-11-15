class CreateExpansions < ActiveRecord::Migration
  
  def self.up
    create_table :expansions do |t|
      t.string :name, {:null => false}
      t.string :display_name, {:null => false}
      t.string :description, {:null => false}
      t.timestamps
    end
  end
  
  def self.down
    drop_table :expansions
  end
  
end
