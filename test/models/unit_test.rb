# == Schema Information
#
# Table name: units
#
#  id             :integer          not null, primary key
#  owner_id       :integer
#  unit_no        :string
#  street1        :string
#  street2        :string
#  city           :string
#  state          :string
#  zip_code       :string
#  room_count     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  calendar_label :string(7)
#

require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
