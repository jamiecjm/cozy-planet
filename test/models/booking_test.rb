# == Schema Information
#
# Table name: bookings
#
#  id                     :integer          not null, primary key
#  unit_id                :integer
#  platform               :string(255)
#  status                 :string(255)
#  guest                  :string(255)
#  check_in               :datetime
#  check_out              :datetime
#  rate                   :float(24)        default(0.0)
#  no_of_nights           :integer          default(1)
#  extra_fee              :float(24)        default(0.0)
#  cleaning_fee           :float(24)        default(0.0)
#  platform_service_fee   :float(24)        default(0.0)
#  total                  :float(24)        default(0.0)
#  total_without_cleaning :float(24)        default(0.0)
#  average_rate           :float(24)        default(0.0)
#  remark                 :text(65535)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
