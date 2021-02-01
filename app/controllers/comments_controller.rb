class CommentsController < ApplicationController

  load_and_authorize_resource except: [:show,:create]

  def create
    # byebug
    @post = Post.find(id = params[:post_id])
    @comment = @post.comments.new(params.require(:comment).permit(:com))
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment is created successfully"
      redirect_to post_path(@post) 
    else
      render 'new'
    end
  end

  def destroy
    # byebug
    @post = Post.find(id = params[:post_id])
    @comment = Comment.find(id = params[:id])
    @comment.destroy
    redirect_to post_path(@post)

  end

  def edit
    @post = Post.find(id = params[:post_id])
    @comment = Comment.find(id = params[:id])
  end

  def update
    # byebug
    @post = Post.find(id = params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.update(params.require(:comment).permit(:com))
      redirect_to post_path(@post)
    else
      redirect_to edit_post_comment(@post,@comment)
    end
  end

end
