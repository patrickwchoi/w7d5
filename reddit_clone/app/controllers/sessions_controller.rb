class SessionsController < ApplicationController
    def new
        @user = User.new
        render :new
    end

    def create
        username = params[:user][:username]
        password = params[:user][:password]
        @user = User.find_by_credentials(username, password)
        if @user
            login(@user)
            redirect_to user_url(@user)
        else
            # here @user is nil because we couldnt find a user
            # with the given credentials -> meaning we cant call
            # @user.errors.full_messages
            flash.now[:errors] = ["Invalid credentials"]
            render :new
        end
    end

    def destroy
        logout if logged_in?
        redirect_to users_url
    end
end
