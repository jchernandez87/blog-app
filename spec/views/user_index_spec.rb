require 'rails_helper'

RSpec.describe 'Index User page', type: :feature do
  before :each do
    @user = User.new(id: 1,
                     name: 'test name',
                     email: 'test@mail.com',
                     bio: 'my bio text',
                     password: 'password',
                     password_confirmation: 'password',
                     role: 'admin',
                     posts_counter: 0)
    @user.skip_confirmation!
    @user.save!
    visit users_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Log in'
  end

  describe 'index page' do
    it 'shows the user img' do
      expect(page).to have_css('img', class: 'user-photo')
    end

    it 'render the user name' do
      expect(page).to have_content('test name')
    end

    it 'shows the correct post count' do
      expect(page).to have_content('Number of posts: 0')
    end

    it 'redirects to the user page' do
      click_on 'test name'
      assert_current_path("/users/#{@user.id}")
    end
  end
end
