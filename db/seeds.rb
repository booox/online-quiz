# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Create User..."

create_account = User.create([email: "lunn@lunn.com", password:"abcabc", password_confirmation: "abcabc", is_admin:"true"])
# #
puts "Admin account created."
# #
create_account_user = User.create([email: "1@1.com", password:"abcabc", password_confirmation: "abcabc", is_admin:"false"])
# #
puts "User account created."



categories = ["临床医学", "人文医学", "计算机会考"]
types = ["单选题", "多选题", "填空题"]

categories.each do |category|
  Category.create([title: category])
end

puts "Categories Created."

types.each do |type|
  Type.create([title: type])
end

puts "Categories Created."
