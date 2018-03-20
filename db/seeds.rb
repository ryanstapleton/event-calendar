User.create!(name: "George Washington", email: "test@test.com", password: "123456", password_confirmation: "123456")
User.create!(name: "Abraham Lincoln", email: "test1@test.com", password: "123456", password_confirmation: "123456")
User.create!(name: "Thomas Jefferson", email: "test2@test.com", password: "123456", password_confirmation: "123456")

puts "3 Users created!"

5.times do |e|
  Event.create!(title: "#{User.find(1).name} event #{e + 1}", date: "01/01/2001", body: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.", location: "Somewhere #{e +1}", user_id: 1, main_image: Rails.root.join("http://via.placeholder.com/600x400"), thumb_image: "http://via.placeholder.com/100x100")
end

puts "5 Events created by #{User.find(1).name}!"

2.times do |e|
  Event.create!(title: "#{User.find(2).name} event #{e + 1}", date: "01/01/2001", body: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.", location: "Somewhere #{e +1}", user_id: 2, main_image: Rails.root.join("http://via.placeholder.com/600x400"), thumb_image: "http://via.placeholder.com/100x100")
end

puts "2 Events created by #{User.find(2).name}!"

3.times do |e|
  Event.create!(title: "#{User.find(3).name} event #{e + 1}", date: "01/01/2001", body: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.", location: "Somewhere #{e +1}", user_id: 3, main_image: Rails.root.join("http://via.placeholder.com/600x400"), thumb_image: "http://via.placeholder.com/100x100")
end

puts "3 Events created by #{User.find(3).name}!"