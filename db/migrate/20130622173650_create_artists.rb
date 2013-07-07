class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name, :null => false
      t.string :description
      t.timestamps
    end
  end
end
