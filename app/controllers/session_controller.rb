# encoding: utf-8
class SessionController < ApplicationController
	def new
		if flash["return_url"]
			@return_url = flash["return_url"]
		end
	end

	def create
		if user = User.authenticate( params[:login], params[:password] )
			session[:user_id] = user.id 
			
			if params[:return_url]
				redirect_to params[:return_url]
			else
				redirect_to root_url
			end
		else
			redirect_to login_url, :notice => "Wrong id/pass. 잘되야..."
		end
	end
	
	def destroy
	
	end
end
