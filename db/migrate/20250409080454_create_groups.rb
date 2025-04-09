class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer :owner_id
      t.integer :artist_id
      t.text :introduction
      t.string :name

      t.timestamps
    end
  end
end
