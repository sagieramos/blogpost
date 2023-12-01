require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts).with_foreign_key('author_id').dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'methods' do
    it 'returns recent posts' do
      user = create(:user)
      posts = create_list(:post, 3, author: user)
      expect(user.recent_posts).to eq(posts.reverse)
    end

    it 'returns recent comments' do
      user = create(:user)
      comments = create_list(:comment, 3, user: user)
      expect(user.recent_comments).to eq(comments.reverse)
    end

    it 'returns recent likes' do
      user = create(:user)
      likes = create_list(:like, 3, user: user)
      expect(user.recent_likes).to eq(likes.reverse)
    end
  end
end
