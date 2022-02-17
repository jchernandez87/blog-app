require 'rails_helper'

RSpec.describe 'Users Controller actions', type: :request do
  describe 'GET /users' do
    it 'returns a correct action' do
      get '/users'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(response.body).to include('Display all users')
    end
  end

  describe 'GET /users/:id' do
    it 'returns a correct action' do
      get '/users/1'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
      expect(response.body).to include('Show one user')
    end
  end
end
