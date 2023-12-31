class FriendshipAcknowledgementsController < ApplicationController
  def create
    friend_request = FriendRequest.find(params[:friend_request][:friend_request_id])

    ActiveRecord::Base.transaction do
      friend_request.update(status: "accepted")
      friendship1 = Friendship.create(user: friend_request.receiver, friend: friend_request.requester)
      friendship2 = Friendship.create(user: friend_request.requester, friend: friend_request.receiver)
      FriendshipAcknowledgement.create(friend_request_id: friend_request.id, friendship_id: [friendship1, friendship2])
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
