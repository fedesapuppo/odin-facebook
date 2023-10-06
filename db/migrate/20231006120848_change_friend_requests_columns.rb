class ChangeFriendRequestsColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :friend_requests, :sender, :requester_id
    rename_column :friend_requests, :receiver, :receiver_id
  end
end
