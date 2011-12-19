require 'test_helper'

class RoutingTest < ActionController::TestCase
	# Session
	test "Session routing" do
		assert_generates '/login', { :controller => 'session', :action => 'new' }
		assert_routing( { :path => '/login', :method => :post }, { :controller => 'session', :action => 'create' } )
		assert_routing( { :path => '/logout', :method => :get }, { :controller => 'session', :action => 'destroy' } )
	end
	
end