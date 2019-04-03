User.create!(user_name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

98.times do |n|
  user_name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(user_name: user_name,
               email: email,
               password:              password,
               password_confirmation: password)
end

User.create!(user_name:  "User",
             email: "user@user.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

users = User.order(:created_at).take(6)
50.times do |n|
  post_name = Faker::Lorem.sentence(1) + "#{n+1}"
  introduction = "introduction to #{post_name}"
  sub_title = "sub_title-#{n+1}"
  content = Faker::Lorem.sentence(3)
  users.each { |user| user.posts.create!(post_name: post_name,
                                      introduction: introduction,
                                         sub_title: sub_title,
                                           content: content ) }
end

user = User.find(5)
user.posts.create!(post_name: "イギリスの歴史豆知識",
                introduction: "Knightの読み方がクニヒトだったころがある",
                   sub_title: "イギリスの歴史から英語の歴史を紐解こう！",
                     content: "イギリスは現在アングロサクソンが中心民族となっていますが、ローマ帝国の支配のあとはさまざまな民族が覇権を争い群雄割拠していた時代がありました。")
user = User.find(4)
user.posts.create!(post_name: "科学史とかいう歴史の闇",
                introduction: "ローマ時代の次に科学史が更新されたのが近世ってやばくない？",
                   sub_title: "ローマ時代",
                     content: "科学史はその名の通り科学の発見に関する歴史ですが、様々な発見があったローマ以前の時代の後、中世には暗黒時代が到来しました。")
user = User.find(3)
user.posts.create!(post_name: "あまり話題に上がらない第一次世界大戦は実はすごい事件だった",
                introduction: "最近第一次世界大戦が見直される機会が増えているように感じたので調べてみました。",
                   sub_title: "１：第一次世界大戦とは？",
                     content: "第一次世界大戦は近代になって最初に訪れた世界規模の大戦です。")
user = User.find(2)
user.posts.create!(post_name: "時代を先取りしすぎた皇帝の話",
                introduction: "歴史好きからよくネタにされる神聖ローマ帝国にすごい人がいた",
                   sub_title: "皇帝フェデリコをご存知ですか？",
                     content: "中世に現在のドイツ一帯を中心に成立した神聖ローマ帝国。ここに時代を先取りしすぎた皇帝がいたのをご存知でしょうか？")
user = User.find(1)
user.posts.create!(post_name: "キングダムの世界観を解説してみた！",
                introduction: "人気漫画「キングダム」が好きなのでまとめてみました",
                   sub_title: "古代中国の勢力図",
                     content: "およそ2700年近くも以前、現在の中国は戦乱の中にありました。")

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

user = users.find(100)
following = users[1..6]
followers = users[1..10]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }