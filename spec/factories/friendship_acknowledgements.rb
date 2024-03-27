FactoryBot.define do
  factory :friendship_acknowledgement do
    association :friend_request
    association :friendship
  end
end
