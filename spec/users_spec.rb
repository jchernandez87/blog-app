require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before :each do
    @user = User.create(id: 1,
                        name: 'new user',
                        email: 'newuser@mail.com',
                        bio: 'my bio text',
                        password: 'password',
                        password_confirmation: 'password',
                        confirmed_at: '2022-03-02 22:25:13.71382',
                        role: 'admin',
                        posts_counter: 0)
    sign_in @user
  end

  describe 'GET /index' do
    before { get '/users' }
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'index' template" do
      expect(response).to render_template('index')
    end
    it 'body has the correct text' do
      expect(response.body).to include('My Rails Blog')
    end
  end

  describe 'GET /index/id' do
    before { get user_path(@user) }
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'show' template" do
      expect(response).to render_template('show')
    end
    it 'body has the correct text' do
      expect(response.body).to include('new user')
    end
  end
end
