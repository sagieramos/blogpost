require 'rails_helper'

RSpec.describe 'User post index page', type: :system do
  before(:each) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')

    6.times do |i|
      Comment.create(post: @post, author: @user, text: "Comment #{i}")
    end
  end

  after(:each) do
    Comment.destroy_all
    Post.destroy_all
    User.destroy_all
  end

  it 'I can see the user\'s profile picture' do
    visit user_posts_path(@user)
    expect(page.find("#user-#{@user.id}img")['src']).to have_content @user.photo
  end

  it 'I can see the user\'s username.' do
    visit user_posts_path(@user)
    expect(page).to have_content @user.name
  end

  it 'I can see the number of posts the user has written.' do
    visit user_posts_path(@user)
    expect(page).to have_content 'Number of Posts: 1'
  end

  it 'I can see a post\'s title.' do
    visit user_posts_path(@user)
    expect(page).to have_content('Hello', normalize_ws: true)
  end

  it 'I can see some of the post\'s body.' do
    visit user_posts_path(@user)
    expect(page).to have_content 'This is my first post'
  end

  it 'I can see the first comments on a post.' do
    visit user_posts_path(@user)
    expect(page).to have_content 'Comment 0'
    expect(page).to have_content 'Comment 1'
    expect(page).to have_content 'Comment 2'
    expect(page).to have_content 'Comment 3'
    expect(page).to have_content 'Comment 4'
    expect(page).to have_content 'Comment 5'
  end

  it 'I can see how many comments a post has.' do
    visit user_posts_path(@user)
    expect(page).to have_content(/Comments: 6/i, normalize_ws: true)
  end

  it 'When I click on a post, it redirects me to that post\'s show page.' do
    visit user_posts_path(@user)
    click_link 'Hello'
    expect(page).to have_content 'This is my first post'
  end
end
