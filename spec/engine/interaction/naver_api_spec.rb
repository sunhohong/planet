# encoding: utf-8
require "spec_helper"

describe "NaverApi" do

  describe "send_location_request" do
    it "should do something" do
      result =  Engine::Interaction::NaverApi.send_location_request("경기도 고양시 덕양구 행신1동")
      result.should_not be nil
      puts "<<<#{result}>>>"
    end
  end

  describe "location_data_by_address" do
    it "should return correct values" do
      result =  Engine::Interaction::NaverApi.location_data_by_address("경기도 고양시 덕양구 행신1동")
      result.should_not be nil
      result[:longitude].should eq "126.8360587"
      result[:latitude].should eq "37.6223432"
    end
  end
end