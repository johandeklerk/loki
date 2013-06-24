class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title, :null => false
      t.date :release_date, :null => false
      t.string :isbn, :null => false
      t.integer :artist_id, :null => false
      t.timestamps
    end
  end
end
