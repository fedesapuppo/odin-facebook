class FriendshipsController < ApplicationController

  def create
    friend = User.find(params[:friend_id])
    if current_user.friendships.create(friend:)
      flash[:notice] = 'Friendship created.'
    else
      flash[:alert] = 'Friendship could not be created.'
    end
    redirect_to friends_path
  end

  def destroy

    friend = User.find(params[:id])
    friendship = current_user.friendships.find_by(friend:)
    if friendship&.destroy
      flash[:notice] = 'Friend removed!'
    else
      flash[:alert] = 'Friend could not be removed.'
    end
    redirect_to friends_path
  end

  private

  def friendship_params
    params.permit(:id)
  end
end
