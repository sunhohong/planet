require 'spec_helper'

describe AutocompleteController do

  describe "GET 'location'" do
    it "returns http success" do
      get 'location'
      response.should be_success
    end
  end

end
