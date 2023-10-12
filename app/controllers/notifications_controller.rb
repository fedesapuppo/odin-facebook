class NotificationsController < ApplicationController
  def index
    @friend_requests = FriendRequest.where(receiver_id: User.first.id, status: "pending")
  end
end
