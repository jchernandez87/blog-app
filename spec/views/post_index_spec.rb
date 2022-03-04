require 'rails_helper'

RSpec.describe 'Post index page', type: :feature do
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
    Post.update_post_count(@user)
    visit user_posts_path(@user.id)
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

    it 'has the correct title' do
      expect(page).to have_content(@post2.title)
    end

    it 'has the correct text' do
      expect(page).to have_content(@post2.text)
    end

    it 'has te correct comment' do
      expect(page).to have_content("This post don't Have any comments")
    end
  end
end
