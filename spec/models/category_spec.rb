require 'spec_helper'

class FacetMock
  attr_accessor :value, :count
  def initialize (value, count)
    self.value, self.count = value, count
  end
end
describe Category do
  before :each do
    @parent_category = FactoryGirl.create(:category)
    @parent_category.depth = 0
    @parent_category.save
    @child1 = FactoryGirl.create(:category)
    @child2 = FactoryGirl.create(:category)
    [@child1, @child2].each { |c| c.parent_id = @parent_category.id; c.depth = 1; c.save }
  end

  describe "should has" do
    it "instance" do
      @parent_category.should_not be nil
    end

    it "an parent association" do
      @child1.parent.should eq @parent_category
    end

    it "an children association" do
      @parent_category.children.count.should be 2
    end
  end

  describe "method find_all_by_facet" do
    before :each do
      @mock_facet = [FacetMock.new(@parent_category.id, 3), FacetMock.new(@child1.id, 5)]
    end

    it "should return root categories without category_id" do
      Category.find_all_by_facet(@mock_facet, nil).count.should be 1
    end

    it "should return sub categories when category_id exist" do
      Category.find_all_by_facet(@mock_facet, @parent_category.id).count.should be 2
      Category.find_all_by_facet(@mock_facet, @parent_category.id).first.facet_count.should be 5
    end
  end
end
