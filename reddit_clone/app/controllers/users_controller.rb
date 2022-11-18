class UsersController < ApplicationController
    # before_action :require_logged_in, only: :show
    def index
        @users = User.all
        render :index
    end

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            render :show
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def show
        if logged_in?
            @user = User.find_by(id: params[:id])
            render :show
        else
            redirect_to new_session_url
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :password)
    end
end
