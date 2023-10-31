Post.destroy_all
User.destroy_all
FriendRequest.destroy_all
Friendship.destroy_all
Like.destroy_all

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
    receiver = other_users.sample
    unless requested_users.include?(receiver)
      requested_users << receiver

      friendship = Friendship.find_by(user: user, friend: receiver)

      unless friendship
        status = [0, 1, 2].sample

        FriendRequest.find_or_create_by(
          requester_id: user.id,
          receiver_id: receiver.id,
          status: status
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

User.all.each do |user|
  @posts = PostsService.new(user).friends_and_own_posts
  10.times do
    post = @posts.sample
    unless Like.exists?(user: user, post: post)
      Like.create!(user: user, post: post)
    end
  end
end
