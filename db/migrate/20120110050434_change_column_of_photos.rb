class ChangeColumnOfPhotos < ActiveRecord::Migration
  def up
    change_table :photos do |t|
      t.rename :parent, :attachable_id
    end
  end

  def down
    change_table :photos do |t|
      t.rename :attachable_id, :parent
    end
  end
end
