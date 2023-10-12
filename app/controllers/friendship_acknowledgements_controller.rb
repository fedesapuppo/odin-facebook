class FriendshipAcknowledgementsController < ApplicationController
  def create
    friend_request = FriendRequest.find(params[:friend_request][:friend_request_id])

    ActiveRecord::Base.transaction do
      friend_request.update(status: "accepted")
      friendship = Friendship.create(user: friend_request.receiver, friend: friend_request.requester)
      friendship = Friendship.create(user: friend_request.requester, friend: friend_request.receiver)
      FriendshipAcknowledgement.create(friend_request: friend_request, friendship: friendship)
    end

    redirect_to notifications_path
  end

  def destroy
    friend_request = FriendRequest.find(params[:friend_request][:friend_request_id])

    friend_request.update(status: "rejected")

    redirect_to notifications_path
  end

  private

  def friendship_acknowledgement_params
    params.require(:friend_request).permit(:friend_request_id)
  end
end
