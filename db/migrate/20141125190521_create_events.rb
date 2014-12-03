class CreateEvents < ActiveRecord::Migration
  def self.up
  	create_table :events do |t|
      t.string :name
      t.string :thumbnail
      t.integer :event_id
      t.text :description
    end
  end

  def self.down
    drop_table :events
  end
end
