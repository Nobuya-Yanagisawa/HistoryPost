User.create!(user_name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  user_name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(user_name: user_name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do |n|
  post_name = "post_name-#{n+1}"
  introduction = "introduction to #{post_name}"
  sub_title = "sub_title-#{n+1}"
  content = Faker::Lorem.sentence(3)
  users.each { |user| user.posts.create!(post_name: post_name + " by " + user.user_name,
                                      introduction: introduction,
                                         sub_title: sub_title,
                                           content: content ) }
end