class AddLatLongToPerson < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :lonlat, :st_point, geographic: true
    add_column :people, :search_range_in_km, :integer, null: true
    add_index :people, :lonlat, using: :gist
  end
end
