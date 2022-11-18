class SubsController < ApplicationController
  def new
    @sub = Sub.new
    render :new
  end

  def create 
    if logged_in?
      @sub = Sub.new(sub_params)
      @sub.moderator_id = current_user.id
      if @sub.save
        render :show
      else 
        flash.now[:errors] = @sub.errors.full_messages
        render :new 
      end 
    else 
      redirect_to new_session_url 
    end
  end

  def index 
    @subs = Sub.all 
    render :index
  end

  def show 
    @sub = Sub.find_by(id: params[:id])
    @posts = Post.where(sub_id: @sub.id)
    render :show
  end

  def edit 
    @sub = Sub.find_by(id: params[:id])
    render :edit
  end

  def update
    if logged_in? 
      @sub = Sub.find_by(id: params[:id])
      if @sub.moderator_id == current_user.id 
        if @sub.update(sub_params)
          render :show
        else 
          flash.now[:errors] = @sub.errors.full_messages 
          render :edit
        end 
      else 
        render :show
      end 
    else 
      redirect_to new_session_url
    end
  end
  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
