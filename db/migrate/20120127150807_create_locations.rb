class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :postal_code
      t.string :si
      t.string :gu
      t.string :dong
      t.float :latitude, :limit => 30
      t.float :longitude, :limit => 30

      t.timestamps
    end
  end
end
