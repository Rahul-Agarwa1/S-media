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
      @all_friends = current_user.except_current_user(@all_friends)
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

  def friend_results #yet to complete, find a way to send the data from FE to BE
    @all_friends = params[:format]
  end

  # check
  def friends
    @user=User.find(params[:user_id])
    @friends=@user.all_friends
  end

  def pendingrequests
    @user=User.find(params[:user_id])
    @pendingrequests=@user.pending_requests
  end

  def receievedrequests
    @user=User.find(params[:user_id])
    @r=@user.received_requests
  end

  def destroy
    @user=User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end


end

