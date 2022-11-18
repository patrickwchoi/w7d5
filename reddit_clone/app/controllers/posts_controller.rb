class PostsController < ApplicationController
    def new
        @post = Post.new
        render :new
    end

    def create
        if logged_in?
            @post = Post.new(post_params)
            @post.sub_id = params[:sub_id]
            @post.author_id = current_user.id
            if @post.save
                render :show
            else
                flash.now[:errors] = @post.errors.full_messages
                render :new
            end
        else
            redirect_to new_session_url
        end
    end

    def show
        @post = Post.find_by(id: params[:id])
        render :show
    end

    def edit
        @post = Post.find_by(id: params[:id])
        render :edit
    end

    def update
        @post = Post.find_by(id: params[:id])
        if @post.author_id == current_user.id
            if @post.update(post_params)
                render :show
            else
                flash.now[:errors] = @post.errors.full_messages
                render :edit
            end
        else
            render :show
        end
    end

    private
    def post_params
        params.require(:post).permit(:title, :url, :content)
    end
end
