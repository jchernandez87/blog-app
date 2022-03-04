require 'rails_helper'

RSpec.describe 'sign in process', type: :feature do
  before :each do
    @user = User.new(name: 'John Doe',
                     email: 'doe@user.com',
                     bio: 'Teacher from Germany',
                     password: 'password',
                     password_confirmation: 'password',
                     posts_counter: 0)
    @user.skip_confirmation!
    @user.save!
  end

  it 'fails to sign with no user or password' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'fails to sign with incorrect password' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'user_email', with: 'another@user.com'
      fill_in 'user_password', with: 'newpassword'
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'signs me in' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'user_email', with: 'doe@user.com'
      fill_in 'user_password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end
