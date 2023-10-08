Post.destroy_all
User.destroy_all
FriendRequest.destroy_all
Friendship.destroy_all

10.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "password",
  )

  if User.count >= 2
    5.times do
      requester = User.where.not(id: user.id).sample
      FriendRequest.create!(requester_id: requester.id, receiver_id: user.id, status: "pending")
      FriendRequest.create!(requester_id: requester.id, receiver_id: user.id, status: "accepted")
      FriendRequest.create!(requester_id: requester.id, receiver_id: user.id, status: "rejected")
    end
  end

  User.all.each do |other_user|
    next if user == other_user
    Friendship.create!(user: user, friend: other_user)
  end
end

User.all.each do |user|
  5.times do
    user.posts.create!(
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph,
    )
  end
end
