User.destroy_all
Post.destroy_all

#crete admin
admin = User.create email: "admin@admin.com",
                    password: "password",
                    role: "admin"

#create users
names = ["sasha","masha","dasha","katya","misha"]
last_names = ["ivanov","petrova","kyznecova","malkina","ovechkin"]
emails = ["sasha@gmail.com", "masha@gmail.com", "dasha@gmail.com", "katya@gmail.com","misha@gmail.com"]
passwords = ["sasha111", "masha111", "dasha111", "katya111","misha111"]
names.count.times do |i|
  User.create name: names[i],
              last_name: last_names[i],
              email: emails[i],
              password: passwords[i]
end

#create posts
title = "Post"
description = "Very very long text..."
life_cycles = [:draft,:publish,:approved,:archive,:new_post]
count = 20
count.times do |i|
post = Post.create title: title + "#{i}",
                   description: description*(i%3),
                   life_cycle: life_cycles[i%3]

#create user has_many posts
User.all[rand(names.count)+1].posts << post
end