class RibbitsController < ApplicationController
def create
  @ribbit = Ribbit.new(ribbit_params)
  @ribbit.user_id = current_user.id
 
  if @ribbit.save
      redirect_to current_user 
  else
      flash[:error] = "Problem!"
      redirect_to current_user
  end
end

def index
    @ribbits = Ribbit.all
    @ribbit = Ribbit.new
end

def ribbit_params
  params.require(:ribbit).permit(:content, :user_id)
end


end
