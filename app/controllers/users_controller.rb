class UsersController < ApplicationController
  def myprofile
    @user = current_user
    @posts =@user.posts
  end
end
