require 'rails_helper'

RSpec.describe 'Post show page', type: :feature do
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
    @comment1 = Comment.create(text: 'My comment', author_id: @user.id, post_id: @post1.id)
    visit user_post_path(@user, @post1)
  end

  describe 'psot show page' do
    it 'has the correct title' do
      expect(page).to have_content(@post1.title)
    end

    it 'render the user name' do
      expect(page).to have_content('test name')
    end

    it 'shows the correct comment count' do
      expect(page).to have_content('Comments: 1')
    end

    it 'shows the correct like count' do
      expect(page).to have_content('Likes: 0')
    end

    it 'has the correct text' do
      expect(page).to have_content(@post1.text)
    end

    it 'has the correct comment' do
      expect(page).to have_content(@comment1.text)
    end

    it 'has the correct comment author' do
      expect(page).to have_content(@user.name)
    end
  end
end
