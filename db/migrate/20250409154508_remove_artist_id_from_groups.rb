class RemoveArtistIdFromGroups < ActiveRecord::Migration[6.1]
  def change
    remove_column :groups, :artist_id, :integer
  end
end
