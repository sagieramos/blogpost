require 'rails_helper'

RSpec.describe 'Users Controller', type: :request do
  describe 'GET /index' do
    it "Redirects to the users' list page" do
      get '/users/id/posts'
      expect(response).to render_template(:index)
      expect(response.body).to include('Here is a list of posts for a given user')
    end

    it 'GET /users should succeed' do
      get '/users/id'
      expect(response.status).to eq(200)
    end

    it 'does not render a different template' do
      get '/users'
      expect(response).to_not render_template(:show)
    end
  end

  describe 'GET /show' do
    it 'Redirects to the user profile page' do
      get '/users/id/'
      expect(response).to render_template(:show)
      expect(response.body).to include('User Details')
    end

    it 'GET users/id should succeed' do
      get '/users/id'
      expect(response.status).to eq(200)
    end

    it 'does not render a different template' do
      get '/users/id'
      expect(response).to_not render_template(:index)
    end
  end
end
