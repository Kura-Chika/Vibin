class CreateArtistPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :artist_posts do |t|
      t.integer :post_id
      t.integer :artist_id

      t.timestamps
    end
  end
end
