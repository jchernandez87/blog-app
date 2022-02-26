require 'rails_helper'

RSpec.describe 'Posts controller actions', type: :request do
  describe 'GET /users/:id/posts' do
    it 'returns a correct action' do
      User.create(id: 1, name: 'Joe', photo: '', bio: 'Teacher from Colombia', posts_counter: 1)
      get('/users/1/posts')
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    it 'returns a correct action' do
      user = User.create(id: 1, name: 'Joe', photo: '', bio: 'Teacher from Colombia', posts_counter: 0)
      Post.create(id: 1, author_id: user.id, title: 'First post', text: 'text sample', comments_counter: 1,
                  likes_counter: 1)
      get('/users/1/posts/1')
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end
end
