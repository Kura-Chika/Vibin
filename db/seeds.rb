# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.find_or_create_by!(email: 'admin@email.com') do |admin|
  admin.password = 'aaaaaa'
  admin.password_confirmation = 'aaaaaa'
end

member1 = User.find_or_create_by!(email: "aaa@aaa") do |user|
  user.nickname = "メンバー1"
  user.password = "111111"
end

member2 = User.find_or_create_by!(email: "bbb@bbb") do |user|
  user.nickname = "メンバー2"
  user.password = "222222"
end


member1.posts.find_or_create_by!(title: "洋ROCKおすすめ紹介") do |post|
  post.body = "今キテるのはBMTH！"
end

member2.posts.find_or_create_by!(title: "SKZのライブ初参戦レポ！") do |post|
  post.body = "SKZのライブ情報共有します！"
end

#10.times do |i|
#  Event.create!(
#    title: "サンプルイベント#{i+1}",
#    start: Time.zone.now + i.days,
#    end: Time.zone.now + i.days + 1.hour
#  )
#end
