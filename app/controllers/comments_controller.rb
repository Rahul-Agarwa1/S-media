class CommentsController < ApplicationController

  def create
    # byebug
    @post = Post.find(id = params[:post_id])
    @comment = @post.comments.create(params.require(:comment).permit(:com))
    # byebug
    @comment.user = current_user
    @comment.save
    redirect_to post_path(@post)
  end

end
