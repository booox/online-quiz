namespace :dev do

  task :fake => :environment do
    User.delete_all
    Event.delete_all

    users = []
    users << User.create!( :email => "admin@example.org", :password => "12345678" )

    10.times do |i|
      users << User.create!( :email => Faker::Internet.email, :password => "12345678")
      puts "Generate User #{i}"
    end

    20.times do |i|
      topic = Event.create!( :name => Faker::Cat.name,
                             :description => Faker::Lorem.paragraph,
                             :user_id => users.sample.id )
      puts "Generate Event #{i}"
    end
  end

  task :fake_event_and_registrations => :environment do
    event = Event.create!( :status => "public", :name => "FullStack Meetup", :friendly_id => "fullstack-meetup")
    t1 = event.tickets.create!( :name => "Guest", :price => 0)
    t2 = event.tickets.create!( :name => "VIP G1", :price => 190)
    t3 = event.tickets.create!( :name => "VIP G2", :price => 199)

    1000.times do |i|
      event.registrations.create!( :status => ["pending", "confirmed"].sample,
                                   :ticket => [t1, t2, t3].sample,
                                   :name => Faker::Cat.name, :email => Faker::Internet.email,
                                   :cellphone => "123456789", :bio => Faker::Lorem.paragraph,
                                   :created_at => Time.now - rand(10).days - rand(24).hours )
    end

    puts "Let's visit http://localhost:3000/admin/events/fullstack-meetup/registrations"
  end

  task :fake_question_and_answer => :environment do
    puts "Go: fake_question_and_answer"
    100.times do |i|
      question = Question.create!( :title => Faker::Lorem.sentence,
                                   :category_id => Category.pluck(:id).sample )
      # puts "test..."
      question.answers.create!( :title => Faker::HarryPotter.quote )
      question.answers.create!( :title => Faker::HarryPotter.quote )
      question.answers.create!( :title => Faker::HarryPotter.quote )
      question.answers.create!( :title => Faker::HarryPotter.quote, :is_right => true)
    end

    puts "Done: fake_question_and_answer"
  end

end
