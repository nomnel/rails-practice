require 'spec_helper'

feature 'Create new post' do
  fixtures :users

  background do
    visit '/login'
    fill_in 'username', with: "test"
    fill_in 'password', with: "test"
    click_button 'Login'
  end

  scenario 'when create post then appear new post on posts_path' do
    visit posts_path
    page.should have_no_content('test_post')
    visit new_post_path
    fill_in 'post[name]', with: 'test_post'
    fill_in 'post[title]', with: 'test_title'
    fill_in 'post[content]', with: 'test_content'
    click_button 'Create Post'
    visit posts_path
    page.should have_content('test_post')
  end
end
