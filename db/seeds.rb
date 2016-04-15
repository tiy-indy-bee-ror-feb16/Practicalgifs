# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do
  User.create!(
    username: Faker::Name.first_name + "_" + Faker::Superhero.power.split()[0],
    email: Faker::Internet.safe_email, password: "password"
  )
end

1000.times do
  Gif.create!(
    url: Giphy.random('technology').image_url.to_s,
    user_id: rand(1..99)
  )
end
