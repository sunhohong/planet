class Item < ActiveRecord::Base
	belongs_to :user

  validate :title, :presence => true

 searchable do
    text :title, :as => :title_korean
    text :description, :as => :description_korean

    string :category, :represent_image, :location
    string :contact, :shipping_method
    integer :price, :shipping_cost
    time :created_at, :updated_at
 end
end

