# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

first_user = User.create(name: 'Tom', photo: 'https://avatars.githubusercontent.com/u/92854204?v=4', bio: 'Teacher from Mexico.')
second_user = User.create(name: 'Lilly', photo: 'https://www.tutorialspoint.com/assets/questions/media/426142-1668760872.png', bio: 'Teacher from Poland.')