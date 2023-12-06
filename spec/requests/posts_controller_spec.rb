require 'rails_helper'

RSpec.describe 'Posts Controller', type: :request do
  describe 'GET /index' do
    it "Redirects to the user posts' page" do
      get '/users/id/posts'
      expect(response).to render_template(:index)
      expect(response.body).to include('Here is a list of posts for a given user')
    end

    it 'GET users/id/posts should succeed' do
      get '/users/id/posts'
      expect(response.status).to eq(200)
    end

    it 'does not render a different template' do
      get '/users/id/posts'
      expect(response).to_not render_template(:show)
    end
  end

  describe 'GET /show' do
    it 'Redirects to the posts profile page' do
      get '/users/id/posts/id'
      expect(response).to render_template(:show)
      expect(response.body).to include('Post Details for User')
    end

    it 'GET users/id/posts/id should succeed' do
      get '/users/id/posts/id'
      expect(response.status).to eq(200)
    end

    it 'does not render a different template' do
      get '/users/id/posts/id'
      expect(response).to_not render_template(:index)
    end
  end
end
