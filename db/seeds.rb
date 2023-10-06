# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb

Post.destroy_all
User.destroy_all

10.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "123456",
  )
end

User.all.each do |user|
  5.times do
    user.posts.create!(
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph,
    )
  end

  # 5.times do
  #   sender = User.where.not(id: user.id).sample
  #  FriendRequest.create!(sender: sender, receiver: user, status: "pending")
  #  FriendRequest.create!(sender: sender, receiver: user, status: "accepted")
  # FriendRequest.create!(sender: sender, receiver: user, status: "rejected")
  #end
end
