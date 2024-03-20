require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  describe 'associations' do
    it { should belong_to(:requester).class_name('User').with_foreign_key('requester_id') }
    it { should belong_to(:receiver).class_name('User').with_foreign_key('receiver_id') }
  end

  describe 'validations' do
    it "validates that :status is either 'pending', 'accepted', or 'rejected'" do
      valid_statuses = %w[pending accepted rejected]
      valid_statuses.each do |valid_status|
        friend_request = FactoryBot.build(:friend_request, status: valid_status)
        expect(friend_request.valid?).to eq(true)
      end
    end
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(pending: 0, accepted: 1, rejected: 2).with_prefix(true) }
  end
end
