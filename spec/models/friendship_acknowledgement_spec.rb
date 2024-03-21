require 'rails_helper'

RSpec.describe FriendshipAcknowledgement, type: :model do
  describe 'associations' do
    it { should belong_to(:friend_request) }
    it { should belong_to(:friendship) }
  end
end
