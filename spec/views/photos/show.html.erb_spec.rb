require 'spec_helper'

describe "photos/show" do
  before(:each) do
    @photo = assign(:photo, stub_model(Photo))
  end

  it "renders attributes in <p>" do
    render
  end
end
