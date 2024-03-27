class FriendRequestsController < ApplicationController
  def create
    receiver = User.find(params[:friend_request][:receiver_id])
    friend_request = current_user.friend_requests.build(requester_id: current_user.id, receiver:,
                                                        status: 'pending')

    if friend_request.save
      flash[:notice] = 'Friend request sent!'
    else
      flash[:alert] = 'Failed to send friend request.'
    end

    redirect_back fallback_location: root_path
  end

  def destroy
    friend_request = FriendRequest.find(params[:id])
    if friend_request.destroy
      flash[:notice] = 'Friend request cancelled.'
    else
      flash[:alert] = 'Failed to cancel friend request.'
    end
    redirect_back fallback_location: root_path
  end
end

private

def friend_request_params
  params.require(:friend_request).permit(:receiver_id)
end
