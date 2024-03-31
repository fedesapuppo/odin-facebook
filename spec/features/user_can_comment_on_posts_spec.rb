require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  scenario 'User signs in, comments on a post' do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post, user:)
    sign_in user
    visit post_path(post)

    fill_in 'comment_content', with: 'VLLC!!'
    click_button 'Submit'

    expect(page).to have_content('VLLC!')
  end
end
