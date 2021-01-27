class PostsController < ApplicationController
  def index
    @post = Post.all
  end

  def new
    @post = Post.new
  end

  def show
    
    # byebug
    @post = Post.find(id = params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def create
    # byebug
    @post = Post.new(params.require(:post).permit(:title,:description))
    @post.user = current_user
    if @post.save
      flash[:notice] = 'saved successfully'
      redirect_to posts_path
    else
      flash[:error] = 'failed to save'
      redirect_to new_post_path
    end
  end

  def destroy
    # byebug
    @post = Post.find(id = params[:id])
    @post.destroy
    redirect_to posts_path
  end

end
