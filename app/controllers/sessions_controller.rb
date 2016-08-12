class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.find_by(email: params[:email].downcase)
  	if @user && @user.authenticate(params[:password])
  		log_in(@user)
  		redirect_to articles_path
  	else
		  flash.now[:notice] = "Invalid Email or Password"
  		render 'new'
  	end
  end

  def destroy
  	log_out
    flash[:notice] = "Logged out successfully"
 		redirect_to articles_path
  end
end
