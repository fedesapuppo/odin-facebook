require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_rich_text(:content) }
  end

  describe 'validations' do
    it 'validates presence of content' do
      should validate_presence_of(:title).with_message("can't be blank")
      should validate_presence_of(:content).with_message("can't be blank")
    end
  end
end
