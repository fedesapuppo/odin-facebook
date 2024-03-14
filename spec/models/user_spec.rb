require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe User, type: :model do
  context 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:friend_requests) }
    it { should have_many(:likes) }
    it { should have_many(:comments) }
  end
end
