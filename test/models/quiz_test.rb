# == Schema Information
#
# Table name: quizzes
#
#  id              :integer          not null, primary key
#  title           :string
#  category_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  questions_count :integer          default(0)
#  is_hidden       :boolean          default(TRUE)
#  quiz_type       :string           default("")
#  cover           :string
#  start_number    :integer
#  end_number      :integer
#  given_number    :integer
#  start_time      :datetime
#  end_time        :datetime
#  is_random       :boolean          default(FALSE)
#

require 'test_helper'

class QuizTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
