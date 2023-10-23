class FriendshipsController < ApplicationController
    before_action :authenticate_user!
  
    def create
        friend = User.find(params[:friend_id])
        if current_user.friendships.create(friend: friend)
          flash[:notice] = "Friendship created."
        else
          flash[:alert] = "Friendship could not be created."
        end
        redirect_to friends_path
    end
  
    def destroy
        friend = User.find(params[:id])
        friendship = current_user.friendships.find_by(friend: friend)
        if friendship&.destroy
          flash[:notice] = "Friendship removed."
        else
          flash[:alert] = "Friendship could not be removed."
        end
        redirect_to friends_path
      end
  end
  