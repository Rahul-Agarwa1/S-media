class LikesController < ApplicationController

  before_action :find_like, only: [:destroy]
  before_action :find_post
  def create
    # byebug
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @like = @post.likes.create(user_id: current_user.id)
    end
    redirect_to post_path(@post)
  end

  def destroy
    # byebug
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
    redirect_to post_path(@post)
  end

  private

  def already_liked?
    Like.where(user_id: current_user.id, post_id:
    params[:post_id]).exists?
  end

  def find_like
    @like = Like.find(params[:id])
  end

  def find_post
    @post = Post.find(id = params[:post_id])
  end


end
