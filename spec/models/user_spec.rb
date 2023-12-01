require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Omar') }
  before { subject.save }

  it 'Name should be present' do
    subject.name = nil
    expect(subject).to_not(be_valid)
  end

  it "shouldn't have any recent posts" do
    expect(subject.recent_posts.length).to eq(0)
  end

  it 'should have a positive posts counter' do
    subject.posts_counter = -1
    expect(subject).to_not(be_valid)
  end

  it 'should have a positive posts counter' do
    subject.posts_counter = -1
    expect(subject).to_not(be_valid)
  end

  it 'displays three recent posts when called' do
    posts = 4.times.map { |i| subject.posts.create(title: "Post #{i}") }

    expect(subject.recent_posts.length).to eq(3)
    expect(subject.recent_posts).to eq(posts.last(3).reverse)
  end
end
