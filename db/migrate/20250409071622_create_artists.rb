class CreateArtists < ActiveRecord::Migration[6.1]
  def change
    create_table :artists do |t|
      t.integer :genre_id
      t.string :name
      t.text :introduction

      t.timestamps
    end
  end
end
