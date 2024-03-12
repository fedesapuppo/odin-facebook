module FriendRequestsHelper
  def friend_request_sent?(user)
    current_user.friend_requests.exists?(receiver_id: user.id)
  end
end
