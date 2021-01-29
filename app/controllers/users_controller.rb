class UsersController < ApplicationController
  def myprofile
    @user = current_user
    @posts =@user.posts
  end

  def myfriends
    @friends = current_user.friends
  end

  def search
    render json: params[:friend] 
    
    # if params[:friend].present?
    #   @friends = User.search(params[:friend])
    #   @friends = current_user.except_current_user(@friends)
    #   if @friends
    #     respond_to do |format|
    #       format.js { render partial: 'users/friend_result' }
    #     end
    #   else
    #     respond_to do |format|
    #       flash.now[:alert] = "Couldn't find user"
    #       format.js { render partial: 'users/friend_result' }
    #     end
    #   end    
    # else
    #   respond_to do |format|
    #     flash.now[:alert] = "Please enter a friend name or email to search"
    #     format.js { render partial: 'users/friend_result' }
    #   end
    # end
  end


end


#  <div class='search-area'>
#   <h3>Search Friends</h3>
#   <%= form_tag search_friend_path, remote: true, method: :get do %>
#     <div class="form-group row">
#       <div class="col-sm-9 no-right-padding">
#         <%= text_field_tag :friend, params[:friend], placeholder: "Name or email", autofocus: true, class: "form-control form-control-lg" %>
#       </div>
#       <div class="col-sm-3 no-left-padding">
#         <%= button_tag type: :submit, class: "btn btn-success" do %>
#           <%= fa_icon 'search 2x' %>
#         <% end %>
#       </div>
#     </div>
#   <% end %>
# </div>