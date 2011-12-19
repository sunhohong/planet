require 'test_helper'

class SessionControllerTest < ActionController::TestCase

	# new
  test "should get new" do
  	# get(:action, params, session_value, flash)
  	get :new
  	assert_response :success
  end
  
  test "should get new with return url" do
  	get(:new, nil, nil, {'return_url' => new_item_path})
  	
  	assert_response :success
  	assert_not_nil assigns(:return_url)
  	assert_equal new_item_path, assigns(:return_url)
  end
  
  # login success
  test "should login success" do
  	user = users(:one)
  	post :create, 'login' => user.login, 'password' => '123456'
  	
  	assert_equal user.id, session[:user_id]
  	assert_redirected_to root_path
  end
  
  test "should return after authorization" do
  	user = users(:one)
  	post :create, 'login' => user.login, 'password' => '123456', 'return_url' => new_item_path
  	
  	assert_redirected_to new_item_path
  end
  
  # login fail
  test "should login fail" do
  	user = users(:one)
  	post :create, 'login' => user.login, 'password' => 'imhacker', 'return_url' => new_item_path
  	
  	assert_redirected_to login_url
  end
  
  # logout
  test "should logout" do
  	get :destroy
  	
  	assert_nil session[:user_id]
  	assert_redirected_to store_url 
  end
end
