require 'csv'

namespace :dev do


  task :fake_question_and_answer => :environment do
    puts "Go: fake_question_and_answer"
    100.times do |i|
      question = Question.create!( :title => Faker::Lorem.sentence,
                                   :category_id => Category.pluck(:id).sample )
      question.answers.create!( :title => Faker::HarryPotter.quote )
      question.answers.create!( :title => Faker::HarryPotter.quote )
      question.answers.create!( :title => Faker::HarryPotter.quote )
      question.answers.create!( :title => Faker::HarryPotter.quote, :is_right => true)
    end

    puts "Done: fake_question_and_answer"
  end


  task :calculate_user_leaderboard => :environment do
    puts "Start..."
    QuizDetail.all.each do |qd|

      element = "user:#{qd.user_id}"

      Leaderboard.award_points_to_user("statistics:quiz:#{qd.quiz_id}", element, 1)

      points = qd.is_correct ? 100 : 10
      Leaderboard.award_points_to_user("score:quiz:#{qd.quiz_id}", element, points)

      key = qd.is_correct ? "right" : "wrong"
      Leaderboard.award_points_to_user("#{key}:quiz:#{qd.quiz_id}", element, 1)
    end

    puts "Done"

  end


end
