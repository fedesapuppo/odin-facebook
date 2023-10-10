class NotificationsController < ApplicationController
  def index
    @friend_requests = current_user.friend_requests.where(status: "pending")
  end
end
