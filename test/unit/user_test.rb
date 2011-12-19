require 'test_helper'

class UserTest < ActiveSupport::TestCase
	### fixture
	test "check fixture" do
		user = users(:one)

		assert_not_nil user
		assert_equal 'sunho', user.login
	end
	
	### authentication
	test "should return user if valid user" do
		user = User.authenticate( 'sunho', '123456')
		
		assert_equal users(:one), user
	end
	
	test "should return error when login invalid user" do

	end
	
	### encryption
	test "should generate_salt generate 32bit salt" do
		user = User.new
		user.generate_salt
		puts user.salt
		
		assert_equal 32, user.salt.length
	end
	
	test "should encrypt_password generate hashed string" do
		encrypted = User.encrypt_password( '123456', User.new.generate_salt );
		puts encrypted
		
		assert_equal 64, encrypted.length
	end
	
	test "should hashed_password be auto assigned" do
		user = User.new
		user.password = '123456'
		
		assert_not_nil user.hashed_password
		assert_not_nil user.salt
		assert_equal 64, user.hashed_password.length
	end
end
