# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Users
# require 'friendly_id'

User.create!(name:  "adminadmin",
             email: "admin@gmail.com",
             password:              "adminadmin",
             password_confirmation: "adminadmin",
             admin: true)

30.times do |n|
  name = Faker::Name.name
  email = "user#{n+1}@gmail.com"
  password = "password"
  User.create!(name: name,
              email: email,
              password:              password,
              password_confirmation: password)
end

# Following
User.all.each do |user|
  following = User.order("random()").limit(6)
  following.each do |followed|
    user.follow(followed) unless followed == user
  end
end

# Categories_words
5.times do
  title = Faker::Address.city
  Category.create!(title: title, description: "")
  category = Category.last
  15.times do
    content = title + " " + Faker::Address.street_name
    Word.create!(content: content, category_id: category.id)
    word = Word.last
    Answer.create!(content: content, word_id: word.id, correct: true)
    3.times do
      content = title + " " + Faker::Address.street_name
      Answer.create!(content: content, word_id: word.id, correct: false)
    end
  end
end
