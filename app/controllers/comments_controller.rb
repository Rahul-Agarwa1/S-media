class CommentsController < ApplicationController

  load_and_authorize_resource except: [:show,:create]
  before_action :find_post, only: [:create,:edit, :update, :destroy]
  before_action :find_comment, only: [:edit, :update, :destroy]


  def create
      respond_to do |format|
        @comment = @post.comments.new(set_params)
        @comment.user = current_user
        if @comment.save
          flash.now[:notice] = "Comment is created successfully"
          format.js { render partial: 'comments/add_comment' }
        end
      end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  def edit
  end

  def update
    if @comment.update(set_params)
      redirect_to post_path(@post)
    else
      redirect_to edit_post_comment(@post,@comment)
    end
  end

  private

  def find_post
    @post = Post.find(id = params[:post_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def set_params
    params.require(:comment).permit(:com)
  end

end
