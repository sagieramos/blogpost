require_relative '../rails_helper'

RSpec.describe Comment, type: :model do
  it 'updates comments counter after create' do
    post = create(:post)
    user = create(:user)
    create(:comment, post: post, user: user)
    expect(post.reload.comments_counter).to eq(1)
  end
end
