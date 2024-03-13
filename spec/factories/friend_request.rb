FactoryBot.define do
  factory :friend_request do
    association :requester, factory: :user
    association :receiver, factory: :user
    status { 'pending' }
  end
end
