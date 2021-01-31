class LikesController < ApplicationController

  before_action :find_like, only: [:destroy]
  before_action :find_post, :find_likable_id, :find_likable_type
  def create
    # byebug
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @like = Like.create(user_id: current_user.id,
      likable_id: find_likable_id, likable_type: find_likable_type )
    end
    # byebug
    redirect_to post_path(@post)
  end

  def destroy
    # byebug
    if !(already_liked?)
      flash[:notice] = "Cannot Unlike"
    else
      @like.destroy
    end
    redirect_to post_path(@post)
  end

  private

  def find_likable_type
    if(params[:comment_id])
      return "Comment"
    else
      return "Post"
    end
  end

  def find_likable_id
    if(params[:comment_id])
      return params[:comment_id]
    else
      return params[:post_id]
    end
  end

  def already_liked?
    Like.where(user_id: current_user.id, likable_id:
    find_likable_id, likable_type:find_likable_type).exists?
  end

  def find_like
    @like = Like.find(params[:id])
  end

  def find_post
    @post = Post.find(id = params[:post_id])
  end


end
