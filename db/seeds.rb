# 10.times do |n|
#   name = "仕事"
#   details = "打ち合わせ"
#   Blog.create!(name: name,
#                details: details,
#                )
# end
#
# 10.times do |n|
#   name = "勉強"
#   details = "rails"
#   Blog.create!(name: name,
#                details: details,
#                )
# end
#
# 10.times do |n|
#   name = "トレーニング"
#   details = "背中"
#   Blog.create!(name: name,
#                details: details,
#                )
# end
#
10.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  User.create!(name: name,
               email: email,
               )
end