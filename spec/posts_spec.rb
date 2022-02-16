require 'rails_helper'

RSpec.describe 'Posts controller actions', type: :request do
  describe 'GET /users/:id/posts' do
    it 'returns a correct action' do
      get '/users'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(response.body).to include('Display all posts')
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    it 'returns a correct action' do
      get '/users/1/posts/1'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
      expect(response.body).to include('Show one post')
    end
  end
end
