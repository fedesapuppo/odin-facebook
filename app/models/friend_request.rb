class FriendRequest < ApplicationRecord
  belongs_to :requester, class_name: "User", foreign_key: "requester_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"

  validates :status, presence: true, inclusion: { in: ["pending", "accepted", "rejected"] }

  scope :pending_requests, -> { where(status: "pending") }
end
