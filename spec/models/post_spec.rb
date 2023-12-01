require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:author) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'callbacks' do
    it 'updates user posts_counter after save' do
      user = create(:user)
      expect { create(:post, author: user) }.to change { user.reload.posts_counter }.by(1)
    end
  end

  describe 'methods' do
    it 'returns recent comments' do
      post = create(:post)
      comments = create_list(:comment, 5, post: post)
      expect(post.recent_comments).to eq(comments.reverse)
    end
  end
end
