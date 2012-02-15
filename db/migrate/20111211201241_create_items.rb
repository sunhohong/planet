class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.integer :category_id
      t.text :description
      t.string :represent_image
      t.integer :price
      t.string :location_id
      t.string :contact
      t.boolean :contact_allow
      t.integer :shipping_cost
      t.string :shipping_method
      t.boolean :deleted
      t.references :user

      t.timestamps
    end
  end
end
