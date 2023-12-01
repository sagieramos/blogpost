require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end

  describe 'callbacks' do
    it 'updates likes_counter after save' do
      post = create(:post)
      expect { create(:like, post: post) }.to change { post.reload.likes_counter }.by(1)
    end
  end
end
