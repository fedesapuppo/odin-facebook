class FriendRequest < ApplicationRecord
  belongs_to :requester, class_name: "User", foreign_key: "requester_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"

  validates :status, presence: true, inclusion: { in: [0, 1, 2] }

  enum :status, { pending: 0, accepted: 1, rejected: 2 }, prefix: true, default: :pending
end
