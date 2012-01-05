class AddFieldsToItems < ActiveRecord::Migration
  def change
    add_column :items, :step, :string
    add_column :items, :confirmed, :boolean
  end
end
