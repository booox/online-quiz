# == Schema Information
#
# Table name: departments
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  alias           :string
#

require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
