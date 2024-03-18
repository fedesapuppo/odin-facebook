class NotificationsController < ApplicationController
  def index
    @friend_requests = FriendRequest.where(receiver_id: current_user, status: 'pending')
  end
end
