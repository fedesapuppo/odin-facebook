class FriendshipAcknowledgement < ApplicationRecord
  belongs_to :friend_request
  belongs_to :friendship
end
