require 'rails_helper'

RSpec.describe 'Show User page', type: :feature do
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
    @post1 = Post.create(title: 'article 1', text: 'My text', author_id: @user.id)
    @post2 = Post.create(title: 'article 2', text: 'My text', author_id: @user.id)
    @post3 = Post.create(title: 'article 3', text: 'My text', author_id: @user.id)
    visit user_path(@user.id)
  end

  describe 'show page' do
    it 'shows the user img' do
      expect(page).to have_css('img', class: 'user-photo')
    end

    it 'render the user name' do
      expect(page).to have_content('test name')
    end

    it 'shows the correct post count' do
      expect(page).to have_content('Number of posts: 3')
    end

    it 'shows the user bio' do
      expect(page).to have_content('my bio text')
    end

    it 'Show 3 posts' do
      expect(page).to have_content(@post1.title)
    end

    it 'shows see all posts' do
      expect(page).to have_content('See all posts')
    end

    it 'redirects to the user posts' do
      click_on 'See all posts'
      assert_current_path("/users/#{@user.id}/posts")
    end
  end
end
