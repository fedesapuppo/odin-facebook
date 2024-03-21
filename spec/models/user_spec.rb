require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe User, type: :model do
  context 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:friend_requests).with_foreign_key(:requester_id) }
    it { should have_many(:likes) }
    it { should have_many(:comments) }
    it { should have_many(:friendships).dependent(:destroy) }
    it { should have_many(:friends).through(:friendships).source(:friend) }
  end
end
