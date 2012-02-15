class CreateFieldMeta < ActiveRecord::Migration
  def change
    create_table :field_meta do |t|
      t.string :name
      t.string :description
      t.boolean :has_values

      t.timestamps
    end
  end
end
