class Category < ActiveRecord::Base
  acts_as_nested_set

  attr_accessor :depth

  has_many :children, :class_name => 'Category', :foreign_key => :parent_id
  belongs_to :parent, :class_name => 'Category', :foreign_key => :parent_id

  def self.find_all_by_facet(facets, category_id)
    facets_hash = facets.inject({}) { |hash, f| hash[f.value.to_s] = f.count; hash }
    category = category_id.blank? ? nil : self.find(category_id)

    if category.nil?
      categories = self.find_all_by_depth(0)
    else
      categories = category.children
    end

    categories.each do |c|
      c.facet_count = facets_hash[c.id.to_s]
    end

    categories
  end

  def hierarchy
    result = []
    current_category = self
    while !current_category.nil?
      result.push current_category
      current_category = current_category.parent
    end
    result
  end

  def facet_count
    @facet_count
  end

  def facet_count=(value)
    @facet_count = value
  end
end
