require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before :each do
    @user = User.new(name: 'new user',
                     email: 'newuser@mail.com',
                     bio: 'my bio text',
                     password: 'password',
                     password_confirmation: 'password',
                     posts_counter: 0)
    @user.skip_confirmation!
    @user.save!
    @post = Post.create(title: 'My title', text: 'My text', author_id: @user.id, comments_counter: 0, likes_counter: 0)
  end

  describe 'GET /index' do
    before { get user_posts_path(@user) }
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'index' template" do
      expect(response).to render_template('index')
    end
    it 'body has the correct text' do
      expect(response.body).to include('My title')
    end
  end

  describe 'GET users/index/posts/1' do
    before { get user_post_path(@user, @post) }
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'show' template" do
      expect(response).to render_template('show')
    end
    it 'body has the correct text' do
      expect(response.body).to include('My text')
    end
  end
end
