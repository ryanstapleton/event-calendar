User.create!(name: "George Washington", email: "test@test.com", password: "123456", password_confirmation: "123456")
User.create!(name: "Abraham Lincoln", email: "test1@test.com", password: "123456", password_confirmation: "123456")
User.create!(name: "Thomas Jefferson", email: "test2@test.com", password: "123456", password_confirmation: "123456")
User.create!(name: "Alexander Hamilton", email: "test3@test.com", password: "123456", password_confirmation: "123456")
User.create!(name: "Bottega Admin", email: "bottegaevents@gmail.com", password: "ilovetocode", password_confirmation: "ilovetocode", roles: "admin")

puts "4 Users created!"
puts "1 Admin created!"

5.times do |e|
  Event.create!(title: "#{User.find(1).name} event #{e + 1}", start: DateTime.now, end: "#{e + 1} hours", body: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.", location: "Somewhere #{e +1}", user_id: 1, main_image: "public/uploads/event/main_image/1/stock_background.jpg")
end

puts "5 Events created by #{User.find(1).name}!"

2.times do |e|
  Event.create!(title: "#{User.find(2).name} event #{e + 1}", start: DateTime.now, end: "#{e + 1} hours", body: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.", location: "Somewhere #{e +1}", user_id: 2, main_image: "public/uploads/event/main_image/1/stock_background.jpg")
end

puts "2 Events created by #{User.find(2).name}!"

3.times do |e|
  Event.create!(title: "#{User.find(3).name} event #{e + 1}", start: DateTime.now, end: "#{e + 1} hours", body: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.", location: "Somewhere #{e +1}", user_id: 3, main_image: "public/uploads/event/main_image/1/stock_background.jpg")
end

puts "3 Events created by #{User.find(3).name}!"