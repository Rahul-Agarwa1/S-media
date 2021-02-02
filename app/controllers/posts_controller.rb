class PostsController < ApplicationController

  load_and_authorize_resource except: [:index,:show,:create]
  
  def index
    # @post = Post.all
    
    #show all current user post
    @my_posts = current_user.posts
    @all_posts = @my_posts
    

    #show his friends posts where(post_type: "friends") or (post_type: "everyone")
    @friends = current_user.all_friends
    @friends.each do |friend|
      @all_posts += friend.posts.where(post_type: "friends")
      @all_posts += friend.posts.where(post_type: "public")
    end

    @post = @all_posts

    # byebug

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
    post_visibility
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
    post_visibility
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

  private

  def post_visibility
    @type = params[:post_type_id]
    if @type == '1'
      @post.post_type = "public"
    elsif @type == '2'
      @post.post_type = "friends"
    else
      @post.post_type = "only me"
    end
  end

end
