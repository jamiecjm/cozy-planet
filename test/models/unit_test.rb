# == Schema Information
#
# Table name: units
#
#  id             :integer          not null, primary key
#  owner_id       :integer
#  unit_no        :string(255)
#  street1        :string(255)
#  street2        :string(255)
#  city           :string(255)
#  state          :string(255)
#  zip_code       :string(255)
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
