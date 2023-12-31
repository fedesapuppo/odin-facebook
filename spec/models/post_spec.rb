require "rails_helper"

RSpec.describe Post, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    # it { should have_many(:likes).dependent(:destroy) }
    # it { should have_many(:comments).dependent(:destroy) }
  end

  context "validations" do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_most(280) }
  end
end
