require 'rails_helper'

RSpec.describe 'Users Controller actions', type: :request do
  describe 'GET /users' do
    it 'returns a correct action' do
      get('/users')
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /users/:id' do
    it 'returns a correct action' do
      @user = User.create(id: 1, name: 'Joe', photo: '', bio: 'Teacher from Colombia', posts_counter: 2)
      get('/users/1')
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end
end
