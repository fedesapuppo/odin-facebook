require 'rails_helper'

RSpec.describe 'friends/index.html.erb', type: :view do
  include Devise::Test::IntegrationHelpers
  include Devise::Test::ControllerHelpers
  before do
    @user = create(:user)
    sign_in @user
    assign(:friends, [create(:user, name: 'My friend', email: 'myfriend@example.com')])
    assign(:users_not_friends, [create(:user, name: 'Not a Friend')])
    render
  end

  it 'displays the header "Your Friends"' do
    expect(rendered).to have_selector('h1', text: 'Your Friends')
  end

  it 'displays the list of friends' do
    expect(rendered).to have_selector('ul') do |ul|
      expect(ul).to have_selector('li', text: 'My friend (email: myfriend@example.com)')
    end
  end

  it 'displays the "Remove Friendship" button for each friend' do
    forms = Capybara.all('.friendship-forms')
    forms.each do |form|
      expect(form).to have_selector('input[type="submit"][value="Remove Friendship"]')
    end
  end

  it 'displays the header "Users Who Are Not Your Friends"' do
    expect(rendered).to have_selector('h1', text: 'Users Who Are Not Your Friends')
  end

  it 'displays the list of users who are not friends' do
    within('Users Who Are Not Your Friends') do
      expect(rendered).to have_selector('ul') do |ul|
        expect(ul).to have_selector('li', text: 'Not a Friend')
      end
    end
  end

  it 'displays the "Back to Home" link' do
    expect(rendered).to have_link('Back to Home', href: posts_path, class: 'btn btn-primary')
  end
end
