# == Schema Information
#
# Table name: bookings
#
#  id                     :integer          not null, primary key
#  unit_id                :integer
#  platform               :string
#  status                 :string
#  guest                  :string
#  check_in               :datetime
#  check_out              :datetime
#  rate                   :float            default(0.0)
#  no_of_nights           :integer          default(1)
#  extra_fee              :float            default(0.0)
#  cleaning_fee           :float            default(0.0)
#  platform_service_fee   :float            default(0.0)
#  total                  :float            default(0.0)
#  total_without_cleaning :float            default(0.0)
#  average_rate           :float            default(0.0)
#  remark                 :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
