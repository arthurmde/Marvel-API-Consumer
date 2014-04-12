class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.integer :character_id
      t.string :name
    end
  end
end
