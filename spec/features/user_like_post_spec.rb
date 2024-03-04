require 'rails_helper'

RSpec.feature 'User Like and Unlike Post', type: :feature do
  scenario 'Logged in user visits posts path, likes a Post and unlikes a Post' do
    post = create(:post)
    like = post.likes.create!(user: post.user)

    sign_in post.user
    visit posts_path

    within('.like-form', match: :first) do
      click_button 'Unlike'
    end

    expect(page).to have_content('Like removed.')

    click_button 'Like'

    expect(page).to have_content('Post liked.')
  end
end
