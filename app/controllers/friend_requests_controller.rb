class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    receiver = User.find(params[:friend_request][:receiver_id])
    friend_request = current_user.friend_requests.build(requester_id: current_user.id, receiver: receiver, status: "pending")

    if friend_request.save
      flash[:notice] = "Friend request sent!"
    else
      flash[:alert] = "Failed to send friend request."
    end

    redirect_back fallback_location: root_path
  end
end

private

def friend_request_params
  params.require(:friend_request).permit(:receiver_id)
end
