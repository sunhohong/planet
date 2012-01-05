class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :description
      t.integer :parent, :seq
      t.string :data_file_name, :data_content_type
      t.integer :data_file_size
      t.datetime :data_updated_at    
    end
  end
end
