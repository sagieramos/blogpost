require 'rails_helper'
RSpec.feature "User Index", type: :feature do
  let(:user1) { User.create!(name: "John Doe", photo: File.open("spec/fixtures/test_image.jpg")) }
  let(:user2) { User.create!(name: "Jane Doe") }
  before do
    @users = [user1, user2]
  end
  scenario "displays user profile picture" do
    visit users_path
    expect(page).to have_css("img.user-photo", count: 1)
    expect(page).to have_css("img.user-photo", src: user1.photo.url)
    expect(page).to have_css("img.user-photo[alt='John Doe's photo']")
  end
  scenario "displays placeholder for user without profile picture" do
    visit users_path
    expect(page).to have_css("div.placeholder-box", count: 1)
  end
  scenario "displays username" do
    visit users_path
    expect(page).to have_content("John Doe")
    expect(page).to have_content("Jane Doe")
  end
  scenario "displays number of posts" do
    visit users_path
    expect(page).to have_content("Number of Posts: #{user1.posts_counter}")
    expect(page).to have_content("Number of Posts: #{user2.posts_counter}")
  end
  scenario "clicking on username redirects to user's show page" do
    visit users_path
    click_link(user1.name)
    expect(current_path).to eq user_path(user1)
    expect(page).to have_content("Showing user #{user1.name}")
  end
end          
