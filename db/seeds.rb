Post.destroy_all
User.destroy_all
FriendRequest.destroy_all
Friendship.destroy_all

10.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "password",
  )
end

User.all.each do |user|
  5.times do
    requester = User.where.not(id: user.id).sample
    Friendship.find_or_create_by(user: requester, friend: user)

    FriendRequest.find_or_create_by(requester_id: requester.id, receiver_id: user.id, status: "pending")
    FriendRequest.find_or_create_by(requester_id: requester.id, receiver_id: user.id, status: "accepted")
    FriendRequest.find_or_create_by(requester_id: requester.id, receiver_id: user.id, status: "rejected")
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
