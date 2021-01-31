class UsersController < ApplicationController
  def myprofile
    @user = current_user
    @posts =@user.posts
  end

  def myfriends
    @friends = current_user.friends
  end

  def show
    # byebug
    @user = User.find(id=params[:id])
    @posts = @user.posts
    
  end


  def search
    
    if params[:friend].present?
      # @friends = User.all
      @all_friends = User.search(params[:friend])
      @friends = @all_friends.first(5)
      # byebug
      if @friends
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          format.js { render partial: 'users/friend_result' }
        end
      end    
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend name or email to search"
        format.js { render partial: 'users/friend_result' }
      end
    end
  end

  def friend_results
    @all_friends = params[:format]
    
    
  end


end

