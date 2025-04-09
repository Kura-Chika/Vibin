class CreateArtistGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :artist_groups do |t|
      t.integer :group_id
      t.integer :artist_id

      t.timestamps
    end
  end
end
