class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :already_logged_in, only: [:new, :create]
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      UserMailer.welcome_email(@user).deliver_now
  		flash[:notice] = "Your account is successfully created"
      log_in(@user)
  		redirect_to articles_path
  	else
  	  render 'new'
  	end
  end

  def show
    #@user = User.find(params[:id])
  end

  def edit
   # @user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your account was upated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    #@user = User.find(params[:id])
    log_out
    @user.destroy
    flash[:notice] = "Your account is deleted"
    redirect_to articles_path
  end



  private
    def user_params
    	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        flash[:notice] = "Insuffient privlage"
        redirect_to articles_path
      end
    end

    def already_logged_in
      if logged_in?
        flash[:notice] = "Please logout to create new account"
        redirect_to articles_path
      end
    end
end
