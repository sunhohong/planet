# encoding: utf-8
require 'spec_helper'

describe Location do
  describe "update_location_by_address" do
    before(:each) do
      @location1 = FactoryGirl.create(:location, :si => "경기", :gu => "고양시 덕양구", :dong => "행신1동")
      @location2 = FactoryGirl.create(:location, :si => "경기", :gu => "고양시 덕양구", :dong => "행신2동")
    end

    it "should update with correct values" do
      Location.update_location_by_address
      Location.find(@location1.id).longitude.should eq 126.8360587
      Location.find(@location2.id).longitude.should eq 126.8330092
    end
  end
end
