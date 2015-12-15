class UsersController < ApplicationController

def new
    if current_user
#        redirect_to buddies_path
	redirect_to current_user
    else
        @user = User.new
    end
end


def index
    @users = User.all
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
    begin
	@user = User.find(params[:id])
	@ribbit = Ribbit.new
	@relationship = Relationship.where(
	    follower_id: current_user.id,
	    followed_id: @user.id
	).first_or_initialize if current_user
    rescue ActiveRecord::RecordNotFound => e
	redirect_to users_path, notice: "No such user."
    end
end

def buddies
    if current_user
        @ribbit = Ribbit.new
        buddies_ids = current_user.followeds.map(&:id).push(current_user.id)
        @ribbits = Ribbit.where(user_id: buddies_ids)
    else
        redirect_to root_url
    end
end

def user_params
  params.require(:user).permit(:avatar_url, :email, :name, :password, :password_confirmation, :username)
end

end
