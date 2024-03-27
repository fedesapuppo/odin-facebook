require 'rails_helper'

RSpec.feature 'Users can create posts', type: :feature, js: true do
  scenario 'User logs in and creates a post' do
    user = create(:user)

    sign_in user
    visit posts_path

    expect(page).to have_content('Timeline')

    click_link 'New Post'

    fill_in 'Title', with: 'Amazing post title!'

    execute_script("document.querySelector('trix-editor').editor.loadHTML('Amazing post content!')")

    click_button 'Create'

    expect(page).to have_content('Post created successfully')
  end
end
