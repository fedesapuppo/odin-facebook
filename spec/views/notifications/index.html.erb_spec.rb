require 'rails_helper'

RSpec.describe 'notifications/index.html.erb', type: :view do
  include Devise::Test::IntegrationHelpers
  include Devise::Test::ControllerHelpers
  before do
    @user = create(:user)
    sign_in @user
    assign(:friend_requests, [
             create(:friend_request, requester: @user, receiver: create(:user)),
             create(:friend_request, requester: @user, receiver: create(:user))
           ])
    render
  end

  it 'displays the header "Notifications"' do
    expect(rendered).to have_selector('h1', text: 'Notifications')
  end

  it 'displays the list of friend requests' do
    expect(rendered).to have_selector('ul') do |ul|
      expect(ul).to have_selector('li', count: 2)

      within(ul) do
        expect(rendered).to have_content('Friend A sent you a friend request.')
        expect(rendered).to have_button('Accept', count: 2)
        expect(rendered).to have_button('Reject', count: 2)
      end
    end
  end
end
