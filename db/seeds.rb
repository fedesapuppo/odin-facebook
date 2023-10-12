Post.destroy_all
User.destroy_all
FriendRequest.destroy_all
Friendship.destroy_all

50.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "password",
  )
end

User.all.each do |user|
  friends = User.where.not(id: user.id).sample(5)

  friends.each do |friend|
    Friendship.find_or_create_by(user: user, friend: friend)
  end
end

User.all.each do |user|
  other_users = User.where.not(id: user.id)
  requested_users = []

  5.times do
    requester = other_users.sample
    unless requested_users.include?(requester)
      requested_users << requester

      friendship = Friendship.find_by(user: user, friend: requester)

      unless friendship
        status = ["pending", "accepted", "rejected"].sample

        FriendRequest.find_or_create_by(
          requester: user,
          receiver: requester,
          status: status,
        )
      end
    end
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
