class Answer < ApplicationRecord
  validates :title, presence: true

  belongs_to :question

  scope :right_answer, -> { where( is_right: true ).first }
end
