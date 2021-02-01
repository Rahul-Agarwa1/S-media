class PostsController < ApplicationController

  load_and_authorize_resource except: [:index,:show,:create]
  
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

  def edit
    @post=Post.find(params[:id])
  end

  def update
    # byebug
    @post = Post.find(id= params[:id])
    if @post.update(params.require(:post).permit(:title,:description))
      flash[:notice] = 'Updated Successfully'
      redirect_to post_path(@post)
    else
      flash[:error] = 'failed to Update'
      redirect_to post_path(@post)
    end

  end

  def destroy
    # byebug
    @post = Post.find(id = params[:id])
    @post.destroy
    redirect_to posts_path
  end

end
