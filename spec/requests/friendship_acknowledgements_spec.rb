require 'rails_helper'

RSpec.describe "FriendshipAcknowledgements", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/friendship_acknowledgements/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/friendship_acknowledgements/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
