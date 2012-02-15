class CreateFieldValues < ActiveRecord::Migration
  def change
    create_table :field_values do |t|
      t.integer :meta_id
      t.string :value
      t.integer :seq
      t.string :name
      t.boolean :default

      t.timestamps
    end
  end
end
