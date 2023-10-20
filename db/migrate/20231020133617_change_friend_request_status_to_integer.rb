class ChangeFriendRequestStatusToInteger < ActiveRecord::Migration[7.0]
  def change
    remove_column :friend_requests, :status
    add_column :friend_requests, :status, :integer, default: 0
  end
end
