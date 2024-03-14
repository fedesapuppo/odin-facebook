class FriendshipAcknowledgementsController < ApplicationController
  before_action :authenticate_user!
  def create
    friend_request = find_friend_request
    acknowledge_friend_request(friend_request, 'accepted')
  end

  def destroy
    friend_request = find_friend_request
    acknowledge_friend_request(friend_request, 'rejected')
  end

  private

  def find_friend_request
    FriendRequest.find(params[:friend_request][:friend_request_id])
  end

  def acknowledge_friend_request(friend_request, status)
    ActiveRecord::Base.transaction do
      friend_request.update!(status:)
      create_friendships(friend_request) if status == 'accepted'
    end
    redirect_to notifications_path
  rescue ActiveRecord::RecordInvalid
    flash[:alert] = 'An error occurred while processing your request. Please try again.'
    redirect_to notifications_path
  end

  def create_friendships(friend_request)
    friendship1 = Friendship.create(user: friend_request.receiver, friend: friend_request.requester)
    friendship2 = Friendship.create(user: friend_request.requester, friend: friend_request.receiver)
    FriendshipAcknowledgement.create(friend_request_id: friend_request.id, friendship_id: [friendship1, friendship2])
  end

  def friendship_acknowledgement_params
    params.require(:friend_request).permit(:friend_request_id)
  end
end
