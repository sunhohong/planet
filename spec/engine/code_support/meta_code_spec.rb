require "rspec"

class Target
  attr_accessor :location
end

describe "MetaCode" do
  before(:each) do
    Target.extend(Engine::CodeSupport::MetaCode)
    Target.code_field :location => 1
    @target = Target.new
  end

  describe "extended class" do
    it "should have MetaCode methods" do
      Target.respond_to?(:code_field).should be(true)
    end

    it "should have methods for field" do
      @target.respond_to?(:location_meta_id).should be true
      @target.respond_to?(:location_code_name).should be true
      @target.respond_to?(:location_code_values).should be true
    end

    it "should return correct code value" do
      @target.location = "1"
      @target.location_meta_id.should be 1
    end

    it "should return value name" do
      FieldValue.create({ :meta_id => 1, :value => 2, :seq => 1, :name => "Seoul"})
      @target.location = "2"
      @target.location_code_name.should eq "Seoul"
    end

    it "should return values" do
      FieldValue.create({ :meta_id => 1, :value => 1, :seq => 1, :name => "Seoul"})
      FieldValue.create({ :meta_id => 1, :value => 2, :seq => 2, :name => "Ilsan"})
      FieldValue.create({ :meta_id => 2, :value => 2, :seq => 1, :name => "Seoul"})
      @target.location = "2"
      @target.location_code_values.count.should be 2
    end

    #describe "code field" do
    #  it "should have MetaCode methods for field" do
    #      Target.code_field :location => 1
    #    @target.location.respond_to?(:meta_id).should be true
    #    @target.location.respond_to?(:value_name).should be true
    #    @target.location.respond_to?(:values).should be true
    #  end
    #
    #  it "should return correct code value" do
    #    @target.location = "1"
    #    @target.code_field :location => 100
    #    @target.location.meta_id.should be 100
    #  end
    #
    #  it "should return value name" do
    #    FieldValue.create({ :meta_id => 1, :value => 2, :seq => 1, :name => "Seoul"})
    #    @target.location = "2"
    #    @target.code_field :location => 1
    #    @target.location.value_name.should eq "Seoul"
    #  end
    #
    #  it "should return values" do
    #    FieldValue.create({ :meta_id => 1, :value => 1, :seq => 1, :name => "Seoul"})
    #    FieldValue.create({ :meta_id => 1, :value => 2, :seq => 2, :name => "Ilsan"})
    #    FieldValue.create({ :meta_id => 2, :value => 2, :seq => 1, :name => "Seoul"})
    #    @target.location = "2"
    #    @target.code_field :location => 1
    #    @target.location.values.count.should be 2
    #  end
    #end
  end
end
