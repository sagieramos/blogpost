require 'rails_helper'

RSpec.describe 'Post show page', type: :system do
  before(:each) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')

    @user2 = User.create(name: 'Alice', photo: 'https://unsplash.com/photos/xyz', bio: 'Alice\'s bio.')
    @comment1 = Comment.create(post: @post, user: @user2, text: 'Great post!')
  end

  after(:each) do
    Comment.destroy_all
    Post.destroy_all
    User.destroy_all
  end

  it 'displays the post\'s title' do
    visit user_post_path(@user, @post)
    expect(page).to have_content 'Hello'
  end

  it 'displays who wrote the post' do
    visit user_post_path(@user, @post)
    expect(page).to have_content 'Tom'
  end

  it 'displays how many comments the post has' do
    visit user_post_path(@user, @post)
    expect(page).to have_content 'Number of Comments: 1'
  end

  it 'displays how many likes the post has' do
    visit user_post_path(@user, @post)
    expect(page).to have_content 'Number of Likes: 0' # Assuming there are no likes for simplicity
  end

  it 'displays the post body' do
    visit user_post_path(@user, @post)
    expect(page).to have_content 'This is my first post'
  end

  it 'displays the username of each commentor' do
    visit user_post_path(@user, @post)
    expect(page).to have_content 'Alice'
  end

  it 'displays the comment each commentor left' do
    visit user_post_path(@user, @post)
    expect(page).to have_content 'Great post!'
  end
end
