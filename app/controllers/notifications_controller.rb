class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @friend_requests = FriendRequest.where(receiver_id: current_user, status: 'pending')
  end
end
