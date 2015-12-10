class UsersController < ApplicationController

def new
    @user = User.new
end

def create
  @user = User.new(user_params)
 
  if @user.save
    redirect_to @user, notice: "Thank you for signing up for Ribbit!"
    session[:user_id] = @user.id
  else
    render 'new'
  end
end

def show
  @user = User.find(params[:id])
  @ribbit = Ribbit.new
end

def user_params
  params.require(:user).permit(:avatar_url, :email, :name, :password, :password_confirmation, :username)
end

end
