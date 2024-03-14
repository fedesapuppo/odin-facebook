class FriendsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_friendship, only: [:destroy]

  def index
    @friend_requests = FriendRequest.where(receiver_id: current_user, status: 'pending')
    @friends = current_user.friends
    @users_not_friends = User.where.not(id: current_user.friends).where.not(id: current_user.id)
  end

  def destroy
    if @friendship
      @friendship.destroy
      flash[:notice] = 'Friendship removed successfully.'
    else
      flash[:alert] = 'Friendship not found.'
    end
    redirect_to friends_path
  end

  private

  def find_friendship
    @friendship = current_user.friendships.find_by(id: params[:id])
  end
end
